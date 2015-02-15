# Feature: PlayStop

Provides the `play` and `stop` requests, as well as the `Playing` and
`Stopped` states.

## Dependencies

`PlayStop` has no dependencies.

## Conflicts

`PlayStop` may conflict with any other playback control sets, and
conflicts with any other feature providing an _initial file-loaded state_.

## States

### `Playing` — playing audio

The state in which the audio source is actively playing.  This state
__should__ be reachable only from `Stopped` (via `play`).

### `Stopped` — not playing audio

The state in which the audio source is stopped playing.  This state __should__
be reachable from `Playing` (via `stop`), but may also be reachable from any
state representing a lack of audio source (for example, `Ejected` from
`FileLoad`).

This __should__ be the _initial state_, unless a state is available representing
a lack of audio source, _and_ the server starts without any audio source loaded.
(For example, if `FileLoad` and `PlayStop` are both implemented, the _initial
state_ __should__ be `Ejected`, not `Stopped`).

For the purposes of `FileLoad`, `Stopped` is the _initial file-loaded state_.

## Requests

### `play` — start playing audio

#### Synopsis

`play`

#### Description

If the current state is `Stopped`, the current state __should__ be set to
`Playing` and the audio source __should__ begin playing.  If the audio source is
a file, it should be played from its last stopped position, or the beginning of
the file if it has not been stopped since loading.

### `stop` — stop playing audio

#### Synopsis

`stop`

#### Description

If the current state is `Playing`, the current state __should__ be set to
`Stopped` and the audio source __should__ stop playing.  If the audio source
is a file, its current position __should__ be carried over to any subsequent
`play` command.

## Responses

`PlayStop` provides no responses.  Confirmation of the `play` and `stop`
requests is provided through the core `STATE` response.
