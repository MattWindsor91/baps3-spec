# Internal API

The BAPS3 _Internal API_ is the API used for communication between BAPS3
_service servers_.  It is designed to meet the following criteria:

* __Composability.__  The API is intended to allow separate implementations of
  single services to be composed into a single logical service, by connecting
  servers together through the API.  Responses and requests not intended for
  a server with upstream and downstream connections respectively can be
  _forwarded_ transparently along the API connections;
* __Transparency.__  The API is text-based, and can be inspected by humans using
  either TCP/IP packet sniffing or connecting directly to services to be
  inspected;
* __Simplicity.__  The API uses a minimalistic line-orientated protocol, in
  which each line is comprised of one or more words, and uses shell-style
  word-escaping conventions (as well as C-style backslash escapes).  It is
  relatively simple to implement, requires little to no external dependencies,
  and is modest in its usage of network bandwidth.

In this section, we discuss the internal API comprehensively, including:

* A specification of the underlying protocol;
* A discussion of how the API can be changed and extended, using the
  `FEATURES` response;
* The requests and responses available in both the core BAPS3 API, and in
  each feature set specified as part of BAPS3.