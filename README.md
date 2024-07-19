# join

[![License](https://img.shields.io/github/license/beatussum/join)](LICENSE)
[![Release](https://img.shields.io/github/v/release/beatussum/join)](https://github.com/beatussum/join/releases/)

[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/beatussum/join/run-tests.yml)](https://github.com/beatussum/join/actions/workflows/run-tests.yml/)
[![codecov](https://codecov.io/gh/beatussum/join/graph/badge.svg)](https://codecov.io/gh/beatussum/join/)

## Table of contents

- [What is join?](#what-is-join)

- [Building](#building)
    - [Dependencies](#dependencies)
    - [Building process](#building-process)

- [Licenses](#licenses)

## What is join?

[**join**](https://github.com/beatussum/join/) is a small script allowing to replace patterns in files by the content of other files.
This script is licensed under GPL-3 or any later version).

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
