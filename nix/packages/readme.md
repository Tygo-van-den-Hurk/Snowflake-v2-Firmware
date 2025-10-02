> This is where we keep the derivations for our packages.

[< Back to nix module README...](../README.md)

# Packages

- [Packages](#packages)
  - [Overview](#overview)
  - [Firmware.nix](#firmwarenix)

## Overview

This directory is for keeping nix derivations or nix packages. This could be dependencies that NixPkgs didn't have, or our own packages we create in this repository. To add a package:

1. Add a directory
1. create a `default.nix` file in `$dir/default.nix`

- This file has to return a derivation when imported.

3. do not forget to stage this directory `git add $dir/` after you are done
1. use `nix build .#$dir` to test that this derivation builds.

## Firmware.nix

Since the auto importer only looks for directories, files are free game. Normally in my template each package has its own directory, but for this one I needed to do something special. I wanted it to automatically create a package for each keymap to make it easier for end users add and build their own keymaps.
