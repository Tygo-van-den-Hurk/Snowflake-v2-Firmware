#!/bin/sh

flash_keyboard() {
    local hand="$1"
    set -e
    clear
    qmk clean --all
    qmk compile --clean --env handedness=$hand
    qmk flash --env handedness=$hand --bootloader avrdude-split-$hand
}

if (return 0 2>/dev/null); then
    export -f flash_keyboard
else
    flash_keyboard "$@"
fi
