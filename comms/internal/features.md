# Features

The internal API uses the concept of _feature flags_ to disclose the available
states, requests, and responses to clients of a service.

The _feature flags_ supported by a service are exposed through the `FEATURES`
core initial response.

## Rationale

### Lightweight

`FEATURES` is not a difficult system to implement.  Baseline services such
as players need only provide a stock response to upstream clients upon
connection.  Services that communicate downstream need only parse the `FEATURES`
command, optionally check for dependencies and conflicts, append their
own features, and emit the result.

### API Reuse

The `FEATURES` system allows the Internal API to be used in multiple different
contexts.  A player implements the same API as a playlist, and the composition
of both into a player-playlist also implements the same API.

### Composability

Due to the ability to pass-through unknown requests and responses, and the
ability to take the union of `FEATURES` responses, two services can be
composed to produce a new service implementing the union of both services'
features.

For example, a playlist service can attach to a player service to provide
playlist functionality on top of that of the player, so long as the player
provides the necessary features for loading and playing files.  The result,
as far as any clients of the playlist are concerned, is a single service that
provides playlist and playback functionality.

Suppose the player, in addition to the required features specified in this
document, supplies a `Volume` feature allowing the player's volume to be
controlled.  Without any special handling by the playlist, the composed service
exposes the `Volume` feature and passes through any volume changes to the
player.

### Enforcing Dependencies

When an upstream service connects to a downstream service, it can check the
downstream `FEATURES` response for any features on which it depends.

For example, the `Playlist` feature depends on the downstream service having
the `FileLoad` feature.

### Preventing Conflicts

In addition, the upstream service can check the downstream `FEATURES` to ensure
that any functionality it provides does not conflict with functionality already
present in the downstream.

This can prevent a service from accidentally being connected to another
instance of itself: a playlist service may refuse to attach to another
playlist service, as it detects that the downstream service already implements
`Playlist`.

### Flexible Clients

`FEATURES` provides clients with flexibility to target multiple different
combinations of BAPS3 services, if they desire, by adapting their user
interfaces to reflect the `FEATURES` declared.

For example, a client may be attached to a player, and display controls for
loading a single file, as well as seeking, playing, stopping and ejecting.  The
same client may also be attached to a playlist-player, at which point it adds
in a playlist interface.  If the playlist-player supports the hypothetical
`Volume` feature, it may then also add a volume control.

This allows a single debug client to be used to test multiple different
combinations of BAPS3 services, for instance.
