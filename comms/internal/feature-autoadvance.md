# Feature: Playlist.AutoAdvance

Provides auto-advance functionality on a playlist.

Auto-advance, when enabled, intercepts an `END` response and automatically
`select`s the next `select`able item in the playlist, if available.
Auto-advance thus skips over text items and other non-playable playlist
content.

## Dependencies

`Playlist.AutoAdvance` depends on both `End` and `Playlist`.

## Conflicts

`Playlist.AutoAdvance` may conflict with any other feature providing
auto-advance functionality.

## Requests

### `autoadvance` — Set Auto-Advance Mode

#### Synopsis

`autoadvance [on|off]`

#### Description

`autoadvance` sets the current auto-advance mode.

An argument of `on` enables auto-advance; an argument of `off` disables it.
If auto-advance is `on`, the server __should__ handle `END` responses as
described above; if auto-advance is `off`, the server __should not__ do so.

## Responses

### `AUTOADVANCE` — Current Auto-Advance Mode

#### Synopsis

`AUTOADVANCE [on|off]`

#### Description

`AUTOADVANCE` __should__ be sent when:

* An upstream connects to this service, as part of the _initial responses_;
  __or__
* The auto-advance behaviour has changed.

The argument corresponds to the current auto-advance mode.
