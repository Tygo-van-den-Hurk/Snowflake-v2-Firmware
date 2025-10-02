> This is where we keep the derivations for our scripts.

[< Back to nix module readme...](../readme.md)

# Scripts

- [Scripts](#scripts)
  - [Overview](#overview)

## Overview

This directory is for keeping nix derivations for scripts. These sub-directories each produce a script that has it's dependencies locked. Allowing for deterministic runs. To add a script:

1. Add a directory
1. create a `default.nix` file in `$dir/default.nix`

- This file has to return a derivation when imported.

3. do not forget to stage this directory `git add $dir/` after you are done
1. use `nix run .#$dir` to test that this derivation builds and runs.
