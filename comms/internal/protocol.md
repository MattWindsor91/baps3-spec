# Protocol

The BAPS3 Internal API sits atop a text-based protocol based upon
[POSIX shell][] conventions.

## Rationale

We use a shell-style protocol because:

* It is lightweight and relatively easy to parse;
* It is a good match for the command-and-arguments style of the BAPS3 API;
* The shell style of escaping is convenient for escaping paths (especially on
  Windows, where the single-quote syntax can avoid needing to escape every
  backslash in a Windows path), which are common arguments to BAPS3 commands
  (`load`, `enqueue`, and so on).

A disadvantage is that it is impossible to perform a context-free splitting of
input into lines; the line-feed character could be escaped.  However, since the
usual transport used by the BAPS3 protocol is TCP, and most TCP libraries
provide unbuffered input in chunks which may be smaller or larger than one line,
we rarely need this luxury.

## Encoding

The internal API is designed to expect requests and responses in the [UTF-8][]
encoding.  However, to allow simple implementations that operate on a per-byte
level, certain uses of UTF-8 beyond the single-byte (ASCII) range are
discouraged.

API users __must__ support the sending and receiving of all single-byte UTF-8
character codes (that is, ASCII), and __should__ support the sending and
receiving of the full UTF-8 range subject to the limitations below.

### Limitations

It is _undefined behaviour_ to:

* Use a whitespace character not in the single-byte subset of UTF-8 to separate
  words.  (See below for recommendations on word-separating whitespace.)  This
  limitation allows implementations to make use of single-byte whitespace
  checks for word separation;
* Backslash-escape a character not in single-byte UTF-8.  (This should not be
  necessary, as single- and double-quote modes will allow these characters to
  be used without escape.)  This limitation allows backslash escaping to
  operate on a single-byte level;
* Backslash-escape the line-feed character.  This limitation is due to the
  special status of line-feed escaping as line continuation in shell
  tokenisation, and may change in future when a decision is made as to the
  necessity of keeping this status in the API.

API users __may__ make decisions as to how to interpret said undefined
behaviour, but __should not__ expect certain behaviour from other users without
consulting the `FEATURES` flags and `OHAI` response for confirmation of said
behaviour.

## Quoting and Escaping

Most characters may be transmitted verbatim via the protocol.  However, in order
to allow separation of protocol communications into the _words_ and _commands_
defined below, BAPS3 gives special meaning to certain characters.  This is
done according to four _quote modes_, specified below.

__Note:__ In case of ambiguity, refer to the [POSIX shell][] quoting standards:
we follow that style of quoting with the exception of disallowing variable and
command interpolation (thus, backtick and dollar are not considered special).

### Unquoted mode

A protocol tokeniser __should__ start in _unquoted_ mode.  In this mode:

* Any run of _whitespace characters_ (see below) separates one word from the next;
* A _line-feed_ character (`0x0A`) separates one command from the next, and
  ends any word preceding;
* A single-quote character (`'`) begins _single-quoted_ mode;
* A double-quote character (`"`) begins _double-quoted_ mode;
* A backslash character (`\`) begins _escaped_ mode;
* Any other character is echoed verbatim.

#### Whitespace

The whitespace characters permitted for word separation __must not__ contain
line-feed (`0x0A`), and __must__ contain space (`0x20`) and horizontal tab
(`0x09`).  Consequently, API users __should__ use the latter two characters for
word separation.  API users __should not__ use multi-byte whitespace
characters, for the reasons provided in _Encoding_.

For implementations in C or C++, the C function [isspace()][] __may__ be used
to identify word-separating whitespace, so long as line-feed is not interpreted
as such.

### Single-quoted mode

In single-quoted mode, only the single-quote character is treated specially, and
has the effect of returning to unquoted mode.

### Double-quoted mode

In double-quoted mode:

* A backslash character begins escaped mode;
* A double-quote character begins unquoted mode;
* Any other character is echoed verbatim.

### Escaped mode

In escaped mode, any single character is treated verbatim; the mode then reverts
to that in which the backslash beginning escaped mode was read.

To allow implementations which escape single bytes instead of characters,
clients __should not__ expect servers to backslash-escape multiple-byte
characters properly, and __should__ instead use single-quoted or double-quoted
mode to escape these characters.

## Words

The core element of the protocol is the _word_, which is a sequence of
zero or more characters delimited by any run of _unquoted_ whitespace.

__Note:__ There is _no_ limit on the number of quote mode transitions inside a
single word.  For example, `unquoted"double"unquoted'single'\ unquoted`
__should__ be considered one word (albeit a pathological one).

## Commands

Each communication over the Internal API consists of a _command_ of one or more
words.  The first, mandatory, word is the _command word_ and unambiguously
identifies the command; any further words are _arguments_ to that command.  In
this respect, the BAPS3 protocol perfectly mirrors shell usage.

Commands are divided into _requests_ and _responses_.

### Requests

_Requests_ are the subset of valid commands that originate from an API client,
and instruct an API service.  Request command words __should__ consist of one
or more _lowercase_ ASCII characters, and __may__ be quoted.

### Responses

_Requests_ are the subset of valid commands that originate from an API service,
and inform an API client.  Response command words __should__ consist of one
or more _uppercase_ ASCII characters, and __may__ be quoted.

### Examples

The following are well-formed commands:

* `stop`
* `"play"`
* `'quit'`
* `enqueue file 0 /home/demo/music/test\ file.mp3`
* `load "/home/demo/music/test file.mp3"`
* `load 'C:\Users\Demo\Music\test file.mp3'`
* `load "C:\\Users\\Demo\\Music\\test file.mp3"`
* `OHAI 'listmaster/playslave'`
* `FEATURES FileLoad PlayStop Seek End TimeReport`

[POSIX shell]: http://pubs.opengroup.org/onlinepubs/009604599/utilities/xcu_chap02.html
[isspace()]:   http://pubs.opengroup.org/onlinepubs/009695399/functions/isspace.html
[UTF-8]:       http://www.ietf.org/rfc/rfc3629.txt