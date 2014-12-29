# Rationale

The division of the BAPS3 system into multiple services is an unusual aspect
of its design, and is inspired primarily by [UNIX philosophy][].  We argue for
this unconventional approach as follows:

* __Modularity:__ Each large chunk of functionality is clearly defined in
  a modular style, with defined inputs and outputs.  This allows for a clean
  distinction between the components of the playout system;
* __Ease of replacement:__ As the services may be implemented separately, each
  resulting server can be swapped out at any time with a compliant alternative,
  with little to no disruption to the rest of the system;
* __Robustness:__ If a service server crashes, the remaining aspects of the
  system can continue in a degraded manner until the server can be replaced.
  For example, if the playlist service is lost, the player can continue to play
  the last selected song without disruption; if the player service is lost, the
  playlist remains intact and can be backed up or used with a replacement
  player instance.
* __Composability:__ Services can be composed to form seamless pipelines of
  playout functionality: a player and playlist can be attached together to form
  a playout channel.  New services can be slotted into an existing pipeline to
  add new functionality, and services can be combined into a single server for
  performance reasons.
* __Network transparency:__ The only service that needs to reside on the
  computer with sound output is (multiple instances of) the player service.  Any
  other services can be allocated to other hardware to balance load and reuse
  resources.

[UNIX philosophy]: http://www.catb.org/esr/writings/taoup/html/ch01s06.html