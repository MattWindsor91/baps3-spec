# Core

Certain requests and responses __should__ be implemented by all BAPS3 servers
understanding the Internal API, and are not associated with any `FEATURES` flag.
These are enumerated here.

## Requests

### `quit` — Quit Server Stack

#### Syntax

`quit`

#### Meaning

`quit` is a request to a server, and all servers downstream from it, to
close gracefully.

The server(s) do not need to acknowledge the `quit` in any manner other than
disconnecting upstream connections.

## Responses

### `FAIL` — Server Failure

#### Syntax

`FAIL <MESSAGE>`

#### Meaning

`FAIL` __must__ be sent to acknowledge a request that has _failed_.
Said request __must__ be provided, in a form identical to the
original request (up to encoding and escaping differences), as the third and
later words of the `FAIL` response.

The second word of the `FAIL` response is a human-readable error message.
Future revisions of the spec __may__ define a structure for this error message.

### `OK` — Command Received

#### Syntax

`OK <COMMAND> [ARGS...]`

#### Meaning

`OK` __must__ be sent to acknowledge a request that has _successfully_
terminated.  Said request __must__ be provided, in a form identical to the
original request (up to encoding and escaping differences), as the second and
later words of the `OK` response.

### `OHAI` — Server Welcome

#### Syntax

`OHAI <IDENTIFIER>`

#### Meaning

`OHAI` __must__ be sent as the first _initial response_ given to any connecting
upstream, and identifies the server (as well as the BAPS3 internal protocol).

Any client connecting to a BAPS3 Internal API-compliant server __may__ take the
absence of an initial `OHAI` as grounds for rejecting the server.  This is not
an absolute requirement.

A server that is the upstream of a second server __should__ reference that
server's _full_ identifier as part of its `OHAI` response.  For example, a
`listmaster` server connecting to a `playslave++` server should report itself
as `listmaster/playslave++`.

A client __may__ use the server's identifier as a hint for enabling
server-specific behaviour: this __should__ be restricted to working around
quirks and bugs in poorly constructed servers, and __should not__ be used for
enabling specific functionality (the `FEATURES` system should be preferred
instead).

### `STATE` — State Update

#### Syntax

`STATE <STATE-NAME>`

#### Meaning

`STATE` __should__ be sent when:

* A new upstream connects to a server, as the _final_ _initial response_;
  __or__
* The server's _state_ changes.

The list of available states always contains the following:

* `Quitting`: the server is preparing to quit, and clients __should not__ send
  responses;
* `Ready`: the server can take responses, but there is no other state that
  better defines the server's current status.

The list of available states is added to by certain features.  For example, the
`PlayStop` feature adds the `Playing` and `Stopped` states, and mandates that
the initial state is `Stopped` unless any other feature specifically overrides
that mandate.  Servers __should not__ use `Ready` if another feature state
better fits its present situation.

### `WHAT` — Bad Command

#### Syntax

`WHAT <MESSAGE> <COMMAND> [ARGS...]`

#### Meaning

`WHAT` __must__ be sent to acknowledge an _invalid_ request: one that does not
fit the syntax of its declared command, or one with an unknown command.
Said request __must__ be provided, in a form identical to the
original request (up to encoding and escaping differences), as the third and
later words of the `WHAT` response.

The second word of the `WHAT` response is a human-readable error message.
Future revisions of the spec __may__ define a structure for this error message.
