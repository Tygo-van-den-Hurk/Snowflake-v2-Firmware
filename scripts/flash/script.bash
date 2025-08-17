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
    echo "  -f, --firmware <path>:       The firmware to flash to the device. Must be a"
    echo "                               directory with the following files:"
    echo "                               firmware_right.hex and firmware_left.hex."
    echo "                               Defaults to building the firmware from the"
    echo "                               current repository if you're in a git repo"
    echo "                               otherwise clones the repository from GitHub"
    echo "                               and builds from there. Can also be set using"
    echo "                               the 'FIRMWARE' environment variable."
    echo ""
}

# Loop through arguments
while [[ $# -gt 0 ]]; do
    case $1 in
    -f|--firmware)
        FIRMWARE="$2"
        shift 2
        ;;
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


if [ -z "$FIRMWARE" ]; then
        
    URL="${URL:-.}"
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        URL="$(git rev-parse --show-toplevel)"
        print "Attempting to build firmware from current git repository."
    fi

    print "building firmware from URL: $URL."
    FIRMWARE="$( nix build "$URL#firmware" --no-link --print-out-paths 2> /dev/null | head -n1)/bin"
    print "flashing firmware from: $FIRMWARE."

    nix_exit_code="$?"
    if [ "$nix_exit_code" -gt 0 ]; then
        echo "Nix build exited with a non-zero code: $nix_exit_code." >&2
        exit $nix_exit_code
    fi
fi

if [[ ! -f "$FIRMWARE/firmware_left.hex" || ! -f "$FIRMWARE/firmware_right.hex" ]]; then
    print "$FIRMWARE is missing firmware_left.hex and firmware_right.hex"
    if [ -d "$FIRMWARE/bin" ]; then
        print "but has bin directory. Assuming this is the directory that you meant."
        FIRMWARE="$FIRMWARE/bin"
    fi
fi

verbose_arg=""
if [[ $verbose -eq 1 ]]; then
    verbose_arg="--verbose"
fi

echo "Flashing left first:"
wait_for "$SERIAL_DEVICE"
avrdude "$verbose_arg" \
    --part atmega32u4 \
    --programmer avr109 \
    --port "$SERIAL_DEVICE" \
    --baud "$BAUD_RATE" \
    --memory "flash:w:${FIRMWARE}/firmware_left.hex:i" \
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
    --memory "flash:w:${FIRMWARE}/firmware_right.hex:i" \
    --noerase 

echo "Flash successful."
