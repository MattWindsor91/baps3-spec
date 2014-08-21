# Services

BAPS3 is comprised of multiple logical _services_.  Each service is intended to
be implemented as a separate server program, but __may__ be merged (for
reasons of performance, maintainability, and so on).

## Core Services

There are six _core services_ that define BAPS3's minimal functionality:

* [Player][];
* [Playlist][];
* [Track Lister][];
* [Track Resolver][];
* [Platform][];
* [Client][].

## Additional Services

Implementations of BAPS3 __may__ define additional services.  Examples of
possible services _not_ specified here include:

* Additional frontends (for debugging purposes, for example);
* Digitising and cataloguing services;
* Installation, deployment and configuration services.

## Chapter Structure

We begin this chapter by discussing the [rationale][] for dividing the BAPS3
system into a comparatively large number of small services.

Next, each core service is detailed in turn.  The services are
defined in terms of:

* Their remits;
* Their interfaces with other services (in brief; a more detailed specification
  follows in the next chapter);
* Their implementation requirements;
* Comparisons with existing software.

[Player]:         player.md
[Playlist]:       playlist.md
[Track Lister]:   tracklister.md
[Track Resolver]: trackresolver.md
[Platform]:       platform.md
[Client]:         client.md
[Rationale]:      rationale.md
