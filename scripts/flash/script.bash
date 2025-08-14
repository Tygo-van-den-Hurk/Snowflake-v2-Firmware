#!/usr/bin/env bash

set -e

# Separates --option=value into '--option' and 'value'.
new_args=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --*=*)
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

export QMK_HOME="$(git rev-parse --show-toplevel)/qmk_firmware"

verbose=0
quiet=0

SERIAL_DEVICE_default="/dev/ttyACM0"
if [ -z "$SERIAL_DEVICE" ]; then
    SERIAL_DEVICE="$SERIAL_DEVICE_default"
fi

BAUD_RATE_default="57600"
if [ -z "$BAUD_RATE" ]; then
    BAUD_RATE="$BAUD_RATE_default"
fi

print_usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "  -h, --help:                  Print this help message."
    echo "  -v, --verbose:               Print extra information. Cannot be combined with"
    echo "                               '--quiet'. Exits with exit code 2 if combined."
    echo "  -q, --quiet:                 Print less information. Cannot be combined with"
    echo "                               '--verbose'. Exits with exit code 2 if combined."
    echo "  -b, --baud-rate <int>:       The baud rate to use when flashing. Expects an"
    echo "                               integer argument. Defaults to $BAUD_RATE_default if not"
    echo "                               specified. Can also be passed as an environment"
    echo "                               variable called: 'BAUD_RATE'."
    echo "  -s, --serial-device <path>:  The serial device to use when flashing."
    echo "                               Defaults to $SERIAL_DEVICE_default. Can also be"
    echo "                               passed as an environment variable called:"
    echo "                               'SERIAL_DEVICE'."
    echo ""
}

# Loop through arguments
while [[ $# -gt 0 ]]; do
    case $1 in
    -s|--serial-device)
        SERIAL_DEVICE="$2"
        shift 2
        ;;
    -b|--baud-rate)
        BAUD_RATE="$2"
        shift 2
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

wait_for() {
    trap 'echo; echo "User interrupt"; exit 1' INT
    printf "  waiting on $1 to appear"
    while [ ! -e "$1" ]; do
    printf "."
    sleep 1.0
    done
    echo
}

if [[ $verbose -eq 1 ]]; then
    verbose_arg="--verbose"
else 
    verbose_arg=""
fi

echo "Flashing left first:"
wait_for "$SERIAL_DEVICE"
avrdude "$verbose_arg" \
    --part atmega32u4 \
    --programmer avr109 \
    --port "$SERIAL_DEVICE" \
    --baud "$BAUD_RATE" \
    --memory flash:w:${firmware}/bin/firmware_left.hex:i \
    --noerase 

echo "Flash successful."
sleep 3

echo "Flashing right next:"
wait_for "$SERIAL_DEVICE"
avrdude "$verbose_arg" \
    --part atmega32u4 \
    --programmer avr109 \
    --port "$SERIAL_DEVICE" \
    --baud "$BAUD_RATE" \
    --memory flash:w:${firmware}/bin/firmware_right.hex:i \
    --noerase 

echo "Flash successful."
