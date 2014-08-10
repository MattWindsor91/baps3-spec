% Services

BAPS3 is comprised of multiple logical _services_.  Each service is intended to
be implemented as a separate server program, but __may__ be merged (for
reasons of performance, maintainability, and so on).

## Core Services

There are six _core services_ that define BAPS3's minimal functionality:

* The [Player](player.md) service;
* The [Playlist](playlist.md) service;
* The [Track Lister](tracklister.md) service;
* The [Track Resolver](trackresolver.md) service;
* The [Platform](platform.md) service;
* The [Client](client.md) service;

## Additional Services

Implementations of BAPS3 __may__ define additional services.  Examples of
possible additional services _not_ specified here include:

* Additional frontend services (for debugging purposes, for example);
* Digitising and cataloguing services;
* Installation, deployment and configuration services.

## Chapter Structure

In this chapter, each core service is detailed in turn.  The services are
defined in terms of:

* Their remits;
* Their interfaces with other services (in brief; a more detailed specification
  follows in the next chapter);
* Their implementation requirements;
* Comparisons with existing software.
