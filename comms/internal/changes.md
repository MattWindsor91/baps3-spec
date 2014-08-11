# API Changes

The internal API is intended to be extensible and changeable.  Its main
feature for supporting change is the `FEATURES` response, which announces to
a service server's clients the abilities of that server.

This section discusses the matter of dealing with API extensions and changes
in a clean and backwards-compatible manner.

## Adding New Features

When adding new requests or responses to the API for a given server, the
server __should__ identify the additional features provided by use of one or
more `FEATURES` flags.

Certain sets of requests and responses have corresponding `FEATURES` flags
defined in the BAPS3 specification.  For example, the `seek` request and
`TIME` response (when sent as a response to a `seek` request) are part of the
`Seek` feature, and the `TIME` response (when sent periodically by the service)
is part of the `TimeReport` feature.  Services __must not__ use requests or
responses specified in this document without announcing the appropriate
feature, __must not__ use request or response words that are specified as part
of a feature in an incompatible manner, and __must__ follow the specifications
for those standard BAPS3 requests, responses and features implemented.

## Extending Existing Features

When adding additional functionality on top of an existing feature, without
changing the meaning of the feature's current requests and responses, the
new functionality __should__ be reported as a _separate_ feature flag.  The flag
__may__ denote its relationship to the original feature by using a string of
the form `EXISTING.NEW`, where `EXISTING` is the existing feature name and
`NEW` is the new feature name.  The new feature __should__ require the presence
of the old feature.

For example, the `Playlist` feature denotes a playlist that allows, by default,
the enqueueing of files only.  To allow text items to be added to the playlist,
the `Playlist.TextItems` feature is also specified.  This does not alter the
`Playlist` feature's semantics.

## Backwards-Incompatible Feature Changes

Any changes to a feature that change the semantics of that feature __must__
be expressed by changing to a different feature string.  A convention that
__may__ be used is appending a revision number to the original feature.  For
example, a backwards-incompatible change to the `Seek` feature could result in
a `Seek-2` feature.

Services __may__ attempt to parse the `FEATURES` flags of downstream services
for version information encoded in this manner, but it is not a required
capability.

Changes to the core requests and responses are considered to create a new
protocol version, which is discussed below.

## Protocol Changes

Any changes to the core internal API protocol __should__ result in the initial
response (`OHAI`) being replaced with a string that cannot be parsed as an
`OHAI` response.  This is to ensure that API implementations can detect the
incompatible protocol change and either switch to the new protocol or terminate
with an error.
