> This repository will contain the firmware for the Snowflake keyboard (version 2).

<br>
<div align="center">
    <a href="https://nixos.org">
      <img src="https://img.shields.io/badge/Built_With-Nix-5277C3.svg?style=flat&logo=nixos&labelColor=73C3D5" alt="Built with Nix"/>
    </a>
    <a href="https://containers.dev/">
      <img src="https://img.shields.io/badge/devcontainer-provided-dark_green?style=flat&logo=docker&logoColor=BEC5C9" alt="devcontainer provided"/>
    </a>
    <!--~ Repository CI/CD ~-->
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/actions/workflows/deploy-github-pages.yml">
      <img src="https://img.shields.io/github/actions/workflow/status/Tygo-van-den-Hurk/Snowflake-v2-Firmware/deploy-github-pages.yml?style=flat&logo=GitHub%20Actions&logoColor=BEC5C9&label=Deploy" alt="GitHub Deployment status">
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/actions/workflows/nix-flake-check.yml">
      <img src="https://img.shields.io/github/actions/workflow/status/Tygo-van-den-Hurk/Snowflake-v2-Firmware/nix-flake-check.yml?style=flat&logo=GitHub%20Actions&logoColor=BEC5C9&label=CI/CD" alt="GitHub CI/CD status">
    </a>
    <!--~ Repository Statistics ~-->
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/graphs/contributors">
      <img src="https://img.shields.io/github/contributors/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="Contributors"/>
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/blob/main/LICENSE">
      <img src="https://img.shields.io/github/license/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="The Eclipse Public License v2.0 badge" />
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/commit">
      <img src="https://badgen.net/github/commits/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="GitHub commits" />
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/commit">
      <img src="https://badgen.net/github/last-commit/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="GitHub latest commit" />
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/network/">
      <img src="https://badgen.net/github/forks/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="GitHub forks" />
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/">
      <img src="https://img.shields.io/github/languages/count/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="amount of languages in the repository" />
    </a>   
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/stargazers">
      <img src="https://img.shields.io/github/stars/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="amount of stars" />
    </a>
    <!--~ Repository Updates ~-->
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/pulse">
      <img src="https://img.shields.io/github/created-at/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="created at badge" />
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/releases">
      <img src="https://img.shields.io/github/release/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat&display_name=release" alt="newest release" />
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware/">
      <img src="https://img.shields.io/github/repo-size/Tygo-van-den-Hurk/Snowflake-v2-Firmware?style=flat" alt="the size of the repository" />
    </a>
    <br>
    <!--~ Banner image ~-->
    <br>
    <a href="https://github.com/Tygo-van-den-Hurk/Snowflake/">
        <img src="https://raw.githubusercontent.com/Tygo-van-den-Hurk/Snowflake/8e8507fbe0d8f01e9ced4e69aea4d65f3241c495/hardware/images/svg/snowflake.svg" alt="The the second version Snowflake PCB">
    </a>   
</div>
<br>

# Snowflake (v2) Firmware

- [Snowflake (v2) Firmware](#snowflake-v2-firmware)
  - [Overview](#overview)
  - [Features](#features)
    - [OS Remapping Support](#os-remapping-support)
    - [Custom Keys](#custom-keys)
    - [Macros](#macros)
  - [Known Issues](#known-issues)
  - [Setup](#setup)
  - [Building](#building)
  - [Flashing](#flashing)
    - [Bootloader](#bootloader)
  - [Credits](#credits)
  - [Licence](#licence)

## Overview

This repository will contain the firmware for the Snowflake keyboard (version 2). Backwards of forwards compatibility is not excluded but not officially supported, use at your own discretion.

- **Keyboard Maintainer**: [Tygo van den Hurk](https://github.com/Tygo-van-den-Hurk)
- **Hardware Availability**: [The official Snowflake hardware repository](https://github.com/legacy-Tygo-van-den-Hurk/Snowflake-firmware-attempt)
- **Hardware Supported**: only the second version of the snowflake

## Features

The Snowflake has some really cool features! Namely [OS Remapping Support](#os-remapping-support), [Custom Keys](#custom-keys), and [Macros](#macros).

### OS Remapping Support

Based on the recognised OS the keyboard will remap some shortcuts to be platform independent. For example, the control modifier on Linux or Windows is the same key as the Command on MacOS. The swap in such a way you'll never notice the difference in your favorite shortcuts!

This mostly goes for the navigation shortcuts. On MacOS to go to the start of a file you press `CMD+UP`, on Windows this is `CTRL+END`. All these are remapped automatically for you. So `PRIMARY+UP` means "go all the way up", `SECONDARY+UP` means go up one bit.

### Custom Keys

The Snowflake has a layer with a bunch of keys who spit out really "unusual" combinations: `CTRL+ALT+SHIFT+SUPER+RANDOM_KEY`. Since they are a combination of 5 keys there is almost no way that any program listens for this and thus they are almost always free to map to. I use these for window manager control. For example: tap this key to move to workspace $n$, and double tab it to move a window to that workspace. Other ideas are: opening your browser, performing a macro, controlling your window manager etc. You would have to implement this on the OS level though.

### Macros

QMK supports 2 macro slots. You can use these to record Key actions that the keyboard will then perform when they are replayed. I'd add more slots, but as of writing QMK only supports these 2 slots.

## Known Issues

When making the arrow key combination 'ALT + ARROW' the keyboard successfully
remaps this to 'CTRL + ARROW' instead. However it does first send the 'ALT'
to the PC, which means that especially on Linux this can trigger menu bar
use. Meaning that your focus goes from the text box into the menu bar.

Thus far there does not seem to be a solution to this problem.

## Setup

If you have `nix` installed, good news: you don't have to do any setup if you don't want to. However there is the `install` command/script in case you'd like to build using the normal QMK way. All you have to do is run `nix run .# install`.

If you do not have `nix` installed, then you have to either install `nix` (recommended) or add this repository as a submodule to the QMK firmware:

```SH
qmk setup --yes # run only if you have not run this in the past
cd ~/qmk_firmware
git submodule add 'https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware.git' lib/snowflake
ln -s ~/qmk_firmware/lib/snowflake/src keyboards/snowflake/v2
```

## Building

Building the firmware:

```SH
nix build 'github:Tygo-van-den-Hurk/Snowflake-v2-Firmware#firmware'
```

or if you have the repository cloned on your machine:

```SH
nix build '/path/to/repository#firmware'
```

or if you do not have `nix` installed:

```SH
# do for both left and right changing the variable at the start
export hand="left"
qmk compile --keyboard snowflake/v2 \
  --keymap default \
  --env handedness=$hand \
  --clean

# Copy or move firmware somewhere after building to not override
# it when making the other hand
mkdir ~/qmk_firmware/tmp
mv ~/qmk_firmware/*.hex ~/qmk_firmware/tmp/firmware_$hand.hex
```

## Flashing

Flashing the firmware for this keyboard (does not require building manually first):

```SH
nix run 'github:Tygo-van-den-Hurk/Snowflake-v2-Firmware#flash'
```

or if you have the repository cloned on your machine

```SH
nix run '/path/to/repository#flash'
```

or if you do not have `nix` installed:

```SH
# do for both left and right changing the variable at the start
hand="left" qmk flash --keyboard snowflake/v2 \
  --keymap default \
  --env handedness=$hand \
  --bootloader avrdude-split-$hand \
  --clean
```

### Bootloader

To enter the bootloader, double press the physical reset button on the PCB twice in rapid succession. The device `/dev/ttyACM*` should show up (where * is an integer).

## Credits

- Tygo van den Hurk \<[@Tygo-van-den-Hurk](https://redirects.tygo.van.den.hurk.dev/github/personal/)>

To see how to start or develop see [CONTRIBUTING.md](./CONTRIBUTING.md).

## Licence

All files within this repository fall under a licence. See [LICENCE](./LICENSE) for more information.
