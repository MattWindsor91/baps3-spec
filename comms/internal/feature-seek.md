# Feature: Seek

Provides the `seek` request, for changing the audio position.

## Dependencies

The audio handled by servers implementing `Seek` __should__ be seekable.
`Seek` provides no means of handling or detecting unseekable audio, except
returning failure from a `seek` request.

## Conflicts

`Seek` may conflict with other seeking features.

## Requests

### `seek` — change position

#### Synopsis

`seek <MICROS>`

#### Description

Seeks the currently playing audio to `MICROS` microseconds.  `MICROS` __must__
be a non-negative integer for the `seek` request to be considered valid.

The position after `seek` __should__ be the closest possible position to
`MICROS`.  If the position is past the end of audio, the server __should__
behave as if the audio had ended of its own accord.

The new position __may__ be reported, for example via the `TIME` response, but
this is outside the scope of this feature.
