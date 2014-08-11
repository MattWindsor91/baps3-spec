# Additional Services

This section, which is not a normative part of the specification, describes
ideas for additional BAPS3 services.

## Cataloguer

A _cataloguer_ service existed in BAPS2, but is not being developed as a core
component of BAPS3.  A cataloguer service would provide an interface for
uploading tracks (from CDs and audio files) into the music library referenced
by the player and track resolver services.

## Streamer

A _streamer_ service is similar to a player service, but cannot load files or
seek, and outputs a live audio stream.  Uses for this service include:

* Integrating outside broadcast feeds into a BAPS3 session;
* Providing a constant sustainer service (jukebox, news, and so on) that
  presenters can use during their show;
* Stand-alone use as a lightweight stream player (possibly even for use when
  playing the radio station's streams).
