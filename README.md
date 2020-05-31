Travis CI integration for FPC / Lazarus
=======================================

Warning
-----
This fork is being used for my personal project [bittorrent-tracker-editor](https://github.com/GerryFerdinandus/bittorrent-tracker-editor).


[![Build Status](https://travis-ci.org/GerryFerdinandus/travis-lazarus.svg?branch=master)](https://travis-ci.org/GerryFerdinandus/travis-lazarus)

[Travis CI](https://travis-ci.org/) currently has no official support for [FreePascal](http://freepascal.org/). This repository demonstrates how FPC and [Lazarus](http://www.lazarus-ide.org/) projects can be used in combination with Travis. There is support for building with multiple Lazarus releases on Travis' `Linux`, `Mac OSX` and `Windows 10` platforms.

Files
-----
`./.travis.install.py` Sets up the environment by downloading and installing the proper FreePascal and Lazarus versions. Run this script in Travis' `install` phase.

`./.travis.yml` Custom Travis setup. Refer to their [documentation](http://docs.travis-ci.com/user/customizing-the-build/) for more information.

`./my_lazarus_test*` Toy project demonstrating a possible test setup.

How to use (see .travis.yml of bittorrent-tracker-editor project)
----------
- [Set up Travis CI for your repository](http://docs.travis-ci.com/user/for-beginners/)
- Add `.travis.install.py` to your repository and run it in the `install` phase.
  - Execute the following command inside your repository:

    ```shell
    git submodule add https://github.com/gerryferdinandus/travis-lazarus.git travis-lazarus
    ```
  - Add the following lines to your `.travis.yml` file:

    ```yaml
    install: ./travis-lazarus/.travis.install.py
    ```
- **[OPTIONAL]** Modify settings to customize build versions.
  - Add (multiple) `LAZ_VER` entries to the `env` table, for example:

    ```yaml
    env:
      - LAZ_VER=1.4.4
      - LAZ_VER=1.6.2
    ```
  - Set the `os` field to specify the target operating system(s):

    ```yaml
    os:
      - linux
      - osx
      - windows
    ```
  - Add Windows 10 server builds:

    ```yaml
    jobs:
      include:
        - os: windows
          env: LAZ_PKG=true
        - os: windows
          env: LAZ_VER=2.0.8 LAZ_REL=64 LAZ_OPT="--os=win32 --cpu=i386"
        - os: windows
          env: LAZ_VER=2.0.8 LAZ_REL=64 LAZ_OPT="--os=win64 --cpu=x86_64"
    ```
  - Use virtual display server 'xvfb-run' if you cannot run your GUI program headless (Linux only):
    ```yaml
    script:
    - if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then xvfb-run $LAZ_ENV ./bin/gui_build_tests --all --format=plain; fi
    ```
  - Other optional environment variables:
    - `LAZ_REL` release platform (use with `LAZ_VER`):
      - Linux: `i386` or `amd64`
      - ~~Mac OSX: `i386` or `powerpc`~~
      - ~~Wine: `32` or `64`~~
      - Windows: `32` or `64`
    - `LAZ_TMP_DIR` temporary directory.
