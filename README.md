# join

[![License](https://img.shields.io/github/license/beatussum/join)](LICENSE)
[![Release](https://img.shields.io/github/v/release/beatussum/join)](https://github.com/beatussum/join/releases/)

[![GitHub Actions Workflow Status (run check)](https://img.shields.io/github/actions/workflow/status/beatussum/join/run-check.yml?label=run%20check)](https://github.com/beatussum/join/actions/workflows/run-check.yml/)
[![GitHub Actions Workflow Status (run tests)](https://img.shields.io/github/actions/workflow/status/beatussum/join/run-tests.yml?label=run%20tests)](https://github.com/beatussum/join/actions/workflows/run-tests.yml/)
[![Codecov](https://codecov.io/gh/beatussum/join/graph/badge.svg)](https://codecov.io/gh/beatussum/join/)
[![CodeFactor](https://www.codefactor.io/repository/github/beatussum/join/badge)](https://www.codefactor.io/repository/github/beatussum/join/)

## Table of contents

- [What is join?](#what-is-join)

- [Building](#building)
    - [Dependencies](#dependencies)
    - [Building process](#building-process)

- [Licenses](#licenses)

## What is join?

[**join**](https://github.com/beatussum/join/) is a small script allowing to replace patterns in files by the content of other files.
This script is licensed under GPL-3 or any later version.

## Usage

```raw
Usage: join [options...] [--] [patterns...] [--] [inputs...]

Options:
  -c,--copyright    Print copyright information.
  -h,--help         Print this message.
  -l,--lines NUM    Set the number of lines to be deleted at the beginning of
                    each entry to NUM.
  -v,--version      Print version information.

Patterns are defined with the following syntax:
  1. @<PATTERN>@=<file>
  2. @<PATTERN>@=<directory>
  3. @<PATTERN>@="<string>"

PATTERN must be uppercase.

With the syntax (1), all the entries @PATTERN@ in inputs will be replaced by the
content of file.

With the syntax (2), all the entries @PATTERN@ in inputs will be replaced by the
content of all the files in directory.

With the syntax (3), all the entries @PATTERN@ in inputs will be replaced by
string. As the shell will probably interpreted double quotes, the latter should
be escaped, e.g. @FOO@='"bar"'.

join Copyright (C) 2024 Mattéo Rossillol‑‑Laruelle <beatussum@protonmail.com>
This program comes with ABSOLUTELY NO WARRANTY; for details type `join --copyright'.
This is free software, and you are welcome to redistribute it
under certain conditions; type `join --copyright' for details.
```

## Building

### Dependencies

- `dev-util/kcov`: only needed for coverage.
- `dev-util/shellspec`[^1]: only needed for testing and coverage.
- `dev-vcs/git`: only needed for building.

All other dependencies are already included in **@system**.

### Building process

1. Clone the repository.

    ```sh
    git clone "https://github.com/beatussum/join.git"
    ```

1. **(optional)** Test the program.

    ```sh
    make -C join test
    ```

    The JUnit report file is at `build/report/results_junit.xml`.

1. **(optional)** Compute code coverage.

    ```sh
    make -C join coverage
    ```

    The output files are in `build/coverage/`.

1. Install the program.

    ```sh
    sudo make -C join DESTDIR=<DESTDIR> PREFIX=<PREFIX> install
    ```

## Licenses

As explained above, the code of this software is licensed under GPL-3 or any later version. Details of the rights applying to the various third-party files are described in the [copyright](copyright) file in [the Debian `debian/copyright` file format](https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/).

[^1]: You can emerge this package by using [my personnal overlay](https://github.com/beatussum/beatussum-overlay/).
