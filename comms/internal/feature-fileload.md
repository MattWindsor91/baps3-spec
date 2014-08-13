# Feature: FileLoad

Provides the `load` request, for loading audio files, and the `FILE` response,
for notifying upstream that a file has been loaded.

## Dependencies

`FileLoad` has no dependencies.

## Conflicts

`FileLoad` may conflict with any other loading features.

## States

### `Ejected` — No File Loaded

The state in which no file is loaded.  Unless the server starts with a file
loaded, this __should__ be the _initial state_, overriding any initial state
provided by a playback control feature (such as `PlayStop`), unless explicitly
overridden by another feature.

## Requests

### `load` — Load File

#### Syntax

`load <PATH>`

#### Meaning

Loads the file at `PATH`, replacing any previously loaded file.

Will succeed and send `FILE` if the file has been loaded successfully.  The
state __should__ then be set to `Stopped`.

If the load failed, the state __should__ be set to `Ejected`.

## Responses

### `FILE` — File Loaded

#### Syntax

`FILE <PATH>`

#### Meaning

`FILE` __should__ be sent when:

* A new upstream connects to a server with the `FileLoad` feature, as part of
  the _initial responses_; __or__
* A new file has been loaded.
