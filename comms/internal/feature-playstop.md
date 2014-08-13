# Feature: PlayStop

Provides the `play` and `stop` requests, as well as the `Playing` and
`Stopped` states.

## Dependencies

`PlayStop` has no dependencies.

## Conflicts

`PlayStop` may conflict with any other playback control sets.

## States

### `Playing` — Playing Audio

The state in which the audio source is actively playing.  This state
__should__ be reachable only from `Stopped` (via `play`).

### `Stopped` — Not Playing Audio

The state in which the audio source is stopped playing.  This state __should__
be reachable from `Playing` (via `stop`), but may also be reachable from any
state representing a lack of audio source (for example, `Ejected` from
`FileLoad`).

This __should__ be the _initial state_, unless a state is available representing
a lack of audio source, _and_ the server starts without any audio source loaded.
(For example, if `FileLoad` and `PlayStop` are both implemented, the _initial
state_ __should__ be `Ejected`, not `Stopped`).
