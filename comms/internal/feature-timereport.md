# Feature: TimeReport

Provides the `TIME` response, for reporting changes in audio position.

## Dependencies

`TimeReport` has no dependencies.

## Conflicts

`TimeReport` may conflict with other time-reporting features.

## Responses

### `TIME` — current time

#### Synopsis

`TIME <MICROS>`

#### Description

Reports the current position in the audio as being `MICROS` microseconds.
`MICROS` __must__ be a non-negative integer for the `TIME` response to be
considered valid.

The `TIME` response __should__ be sent as part of the server's _initial
responses_, if it is currently playing audio.  It __may__ be sent by the server
at any time, and __should__ ideally be sent at a periodic rate of less than one
second to allow clients to update their position counters in a smooth manner.
