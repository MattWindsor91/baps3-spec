# Feature: End

Provides the `END` response, sent when an audio source ends of its own accord.

## Dependencies

`End` has no dependencies.

## Conflicts

`End` has no conflicts.

## Requests

`End` provides no requests.

## Responses

### `END`

#### Syntax

`END`

#### Meaning

`END` __should__ be sent when:

* The current state is `Playing`; __and__
* The current audio source (stream or file) has reached its end; __and__
* The audio end is not due to any request from upstream (the end was not caused
  by a `stop`, `eject`, or `quit` request, for instance).

`END` __may__ be used as a signal to perform some action on the end of an
audio source.  For example, implementations of `AutoAdvance` __should__ use
`END` as a trigger to set up the auto-advance.
