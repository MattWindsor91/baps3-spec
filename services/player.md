# Player

The _player_ service plays audio files.  It is supplied a single file at a time,
and allows the playback to be controlled by upstream services through a basic
API (`stop`, `play`, `seek`, `load`, and `eject`).

Conceptually, a player represents part of a single _playout channel_, with the
_playlist_ service providing the rest.  Since the usual configuration of a BAPS3
system will use more than one channel, a playout machine will likely host more
than one instance of the player service.

## Interface

The player uses the internal API to communicate with the playlist service.  It
understands the following requests:

* `play` — Plays the currently loaded file;
* `stop` — Stops the currently loaded file;
* `load` — Loads a new file;
* `eject` — Unloads the currently loaded file;
* `seek` — Seeks to a new position in the currently loaded file;
* `quit` — Quits the player.

It emits the following responses:

* `OHAI` — Identifies the player implementation and welcomes the client;
* `STATE` — A state change has occurred;
* `TIME` — The current position in the loaded file, sent periodically;
* `END` — The file has ended of its own accord (not via user intervention);
* `OKAY` — A client request was successfully honoured;
* `WHAT` — A client request was not understood;
* `FAIL` — An error has occurred;
* `FILE` — The currently loaded file;
* `FEATURES` — The set of features implemented by the player.

## Implemented Features

The player __must__ implement, as a minimum, the `End`, `FileLoad`,
`PlayStop`, `Seek`, and `TimeReport` features.

## Requirements

__Interface compatibility.__  The player __must__ implement the above interface.
It __may__ implement a superset of the interface, in order to implement more
features than those required by the player.

__File loads.__  The player __must__ be able to load and play files, given their
absolute path on the local filesystem.

__Configurable audio sink.__  The player __must__ allow its audio sink to be
configured.  This allows a playout machine to direct each player to a separate
physical or logical sound-card, which is important for allowing each playback
channel to be routed to a separate mixing desk fader.

__Non-conflicting API endpoint.__  The player __must__ allow its API end-point
to be set up so as not to conflict with other BAPS3 services on the same
machine.  For example, if it exposes a TCP socket, the port should be
configurable; if it exposes a _stdin/stdout_ interface, then no action is needed
as this cannot conflict with other services.  This is to allow multiple such
services to co-exist on the same machine, which is important for the
multiple-output-channel use case mentioned above.
