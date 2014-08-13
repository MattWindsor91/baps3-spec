# Core

Certain requests and responses __should__ be implemented by all BAPS3 servers
understanding the Internal API, and are not associated with any `FEATURES` flag.
These are enumerated here.

## Requests

### `quit`

#### Syntax

`quit`

#### Meaning

`quit` is a request to a server, and all servers downstream from it, to
close gracefully.

The server(s) do not need to acknowledge the `quit` in any manner other than
disconnecting upstream connections.

## Responses

### `FAIL`

#### Syntax

`FAIL <COMMAND> [ARGS...]`

### `OKAY`

#### Syntax

`OKAY <COMMAND> [ARGS...]`

### `OHAI`

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

### `STATE`

#### Syntax

`STATE <STATE-NAME>`

#### Meaning

`STATE` __should__ be sent when:

* A new upstream connects to a server with _at least_ two states, as part of
  the _initial responses_; __or__
* The server's _state_ changes.

The list of available states starts empty, and is added to by certain features.
For example, the `PlayStop` feature adds the `Playing` and `Stopped` states,
and mandates that the initial state is `Stopped` unless any other feature
specifically overrides that mandate.

If the server does not make use of a state machine, then `STATE` is redundant
and __may__ be left unimplemented.

### `WHAT`
