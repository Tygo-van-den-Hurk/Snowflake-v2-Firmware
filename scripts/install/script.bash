#!/usr/bin/env bash

set -e

# Separates --option=value into '--option' and 'value'.
new_args=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        -*=*)
            key="${1%%=*}"
            val="${1#*=}"
            new_args+=("$key" "$val")
            shift
            ;;
        *)
            new_args+=("$1")
            shift
            ;;
    esac
done

set -- "${new_args[@]}"

print_usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "  -h, --help:     print this help message."
    echo "  -v, --verbose:  print extra information. Cannot be combined with '--quiet'."
    echo "  -q, --quiet:    print less information. Cannot be combined with '--verbose'."
    echo "  -g, --globally: install globally instead of locally in the repository."
    echo "                  Not recommended because it mutates and depends on a global state."
    echo ""
}

VERSION=${VERSION:-"0.28.10"}
globally=0
verbose=0
quiet=0

# Loop through arguments
while [[ $# -gt 0 ]]; do
    case $1 in
    -g|--globally)
        globally=1
        shift
        ;;
    -v|--verbose)
        verbose=1
        shift
        ;;
    -q|--quiet)
        quiet=1
        shift
        ;;
    -h|--help)
        print_usage
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done

print() {
    if [[ $quiet -eq 1 ]]; then
        return
    else 
        echo "$@"
    fi
}

if [[ $verbose -eq 1 && $quiet -eq 1 ]]; then
    echo "Cannot combine '--verbose' and '--quiet'."
    exit 2 
fi

ROOT="$(git rev-parse --show-toplevel)"

if [[ $globally -eq 1 ]]; then
    export QMK_HOME="$HOME/qmk_firmware"
else
    export QMK_HOME="$ROOT/qmk_firmware"
fi

print "QMK_HOME=$QMK_HOME"

export INSTALL_DIRECTORY="$QMK_HOME/keyboards/snowflake"
export INSTALL_LOCATION="$INSTALL_DIRECTORY/v2"

if [ -d "$INSTALL_LOCATION" ]; then
    print "Already installed at $INSTALL_LOCATION."
    print "remove the folder to reinstall."
    exit 0
fi

if [ ! -d "$QMK_HOME" ]; then
    
    if [[ $globally -eq 1 ]]; then
        print "Cloning QMK firmware repository..."
        git clone https://github.com/qmk/qmk_firmware.git $QMK_HOME
        PWD="$QMK_HOME" git submodule update --init --recursive
        PWD="$QMK_HOME" git checkout "$VERSION"
    else
        print "Initialising git submodule in this repository..."
        PWD="$ROOT" git submodule update --init --recursive
    fi    
else
    print "Already cloned QMK firmware repository."
fi

if [ ! -d "$QMK_HOME" ]; then
    print "Somehow $QMK_HOME was not created"
    exit 1
fi

if [ ! -d "$INSTALL_DIRECTORY" ]; then
    print "Creating $INSTALL_DIRECTORY for installation later..."
    mkdir -p "$INSTALL_DIRECTORY"
fi

ln -s "$ROOT/src" "$INSTALL_LOCATION"

print "Finished! Installed at: '$INSTALL_LOCATION'"
