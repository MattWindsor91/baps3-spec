# Playlist

The _playlist_ service maintains a playlist on top of the player service.  The
playlist contains both _file items_, which represent files available to load
into the player, and _text items_, which are comments that can be added into the
playlist, but are not loadable and will be skipped over by the playlist.

## Interface

The playlist uses the internal API to communicate both with the platform above
it, and the player below.

The playlist exposes an API on top of the player, delegating any commands it
doesn't understand to the player itself.  It adds the following requests to
the interface:

* `enqueue` — Adds a file or text item into the playlist;
* `dequeue` — Removes a file or text item from the playlist;
* `clear` — Removes all items from the playlist.
* `select` — Selects a file item in the playlist, loading it into the player;
* `list` — Enumerates the items in the playlist, alongside their types;

In addition, it overrides the following player requests:

* `load` — Clears the playlist, enqueues the requested file, and selects it.
* `eject` — Deselects the current selected item and unloads it from the player;
* `quit` — Quits both the playlist and player services.

It also adds the following responses to those sent by the player:

* `ENQUEUE` — An item has been enqueued;
* `DEQUEUE` — An item has been dequeued;
* `SELECT` — The selection has been changed;
* `COUNT` — The current number of items in the playlist;
* `LIST` — A playlist item.

## Implemented Features

The playlist __must__ implement, as a minimum, the `Playlist`,
`Playlist.TextItems`, and `AutoAdvance` features.

## Requirements

__Interface compatibility.__  The playlist __must__ implement the above
interface. It __may__ implement a superset of the interface, in order to
implement more features than those required by the playlist.

__File and text loading.__  The playlist __should__ allow both files and text
items to be enqueued, and __must__ disregard text items for the purposes of
selection and auto-advancing.  If the playlist does not allow text items, it
__must__ notify the platform of this deficiency via the `FEATURES` response.

__Features propagation.__  The playlist __must__ announce those features of the
player to which it allows access, and __must__ hide those features of the player
to which it does not.

__Flexible player selection.__  The playlist __should__ allow the configurable
selection of the player instance to which it will attach.  For example, a
TCP/IP-based playlist service should allow the player port and address to be
selected.  If the playlist spawns, or contains, its own player, this may be
disregarded.
