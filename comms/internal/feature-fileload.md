# Feature: FileLoad

Provides the `load` request, for loading audio files, and the `FILE` response,
for notifying upstream that a file has been loaded.

## Dependencies

`FileLoad` depends on the concept of an _initial file-loaded state_,
which is supplied by another feature such as `PlayStop`.  Should no
other feature provide such a state, the default state `Ready` __may__ be used.

## Conflicts

`FileLoad` may conflict with any other loading features.

## States

### `Ejected` — no file loaded

The state in which no file is loaded.  Unless the server starts with a file
loaded, this __should__ be the _initial state_, overriding any initial state
provided by a playback control feature (such as `PlayStop`), unless explicitly
overridden by another feature.

## Requests

### `load` — load file

#### Synopsis

`load <PATH>`

#### Description

Loads the file at `PATH`, replacing any previously loaded file.

Will succeed and send `FILE` if the file has been loaded successfully.  The
state __should__ then be set to the initial file-loaded state.

If the load failed, the state __should__ be set to `Ejected`.

## Responses

### `FILE` — file loaded

#### Synopsis

`FILE <PATH>`

#### Description

`FILE` __should__ be sent when:

* A new upstream connects to a server with the `FileLoad` feature, as part of
  the _initial responses_; __or__
* A new file has been loaded.
