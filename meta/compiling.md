# Compiling this document

This document may be compiled using
[gitbook](https://github.com/GitbookIO/gitbook); see the readme of that project
for details.  It may also work, to some extent, with
[rustbook](https://github.com/aturon/rust-book).

## Source

The latest source is available via its
[GitHub repository](https://github.com/UniversityRadioYork/baps3-spec).

## Makefile

The source distribution contains a GNU `Makefile`, which provides a thin layer
over common compilation tasks:

* `make` or `make book` will run `rustbook build`;
* `make gh-pages` will build the book, then checkout the `gh-pages` branch and
  commit the book's contents into that branch, and is useful for updating the
  Github Pages version of the specification.

## Contributing

To contribute to this specification:

* [Fork](https://github.com/UniversityRadioYork/baps3-spec/fork) the
  specification on GitHub;
* Make any desired changes;
* Submit the changes as a _pull request_ via GitHub.

You can also submit issues via the GitHub
[issue page](https://github.com/UniversityRadioYork/baps3-spec/issues).
