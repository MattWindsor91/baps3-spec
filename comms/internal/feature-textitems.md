# Feature: Playlist.TextItems

Provides the ability to enqueue items with type `text`.

## Dependencies

`Playlist.TextItems` depends on `Playlist`.

## Conflicts

No known conflicts.

## Item Types

### `text` — textual playlist items

Items of type `text` take one argument, an arbitrary string, and represent the
use of that string as an in-playlist comment.  Such items __must not__ be
`select`able.
