#!/usr/bin/env bash

set -e

# Separates --option=value into '--option' and 'value'.
# Also splits compact short options like '-abc' into '-a' '-b' '-c'.
new_args=()
while [[ $# -gt 0 ]]; do
  case "$1" in
  -*=*) # Handle --option=value
    key="${1%%=*}"
    val="${1#*=}"
    new_args+=("$key" "$val")
    shift
    ;;
  -[!-]?*) # Handle compact short options (e.g. -abc)
    flags="${1#-}"
    for ((i = 0; i < ${#flags}; i++)); do
      new_args+=("-${flags:i:1}")
    done
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
  echo "  -h, --help:               Print this help message."
  echo "  -v, --verbose:            Print extra information. Cannot be combined with"
  echo "                            '--quiet'. Exits with exit code 2 if combined."
  echo "  -q, --quiet:              Print less information. Cannot be combined with"
  echo "                            '--verbose'. Exits with exit code 2 if combined."
  echo "  -i, --install[-locally]:  Installs the firmware in a QMK repository. This"
  echo "                            install is locally within this repository. "
  echo "  -I, --install-globally:   Installs the firmware in a QMK repository. This"
  echo "                            install is done in your home directory as QMK"
  echo "                            prefers it. Warning: This mutates a global state."
  echo "                            This is therefor not recommended."
  echo ""
}

install_globally=0
install_locally=0
verbose=0
quiet=0

# Loop through arguments
while [[ $# -gt 0 ]]; do
  case $1 in
  -I | --install-globally)
    install_globally=1
    shift
    ;;
  -i | --install | --install-locally)
    install_locally=1
    shift
    ;;
  -v | --verbose)
    verbose=1
    shift
    ;;
  -q | --quiet)
    quiet=1
    shift
    ;;
  -h | --help)
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

verbose_arg=""
if [[ $verbose -eq 1 ]]; then
  verbose_arg="--verbose"
fi

quiet_arg=""
if [[ $quiet -eq 1 ]]; then
  quiet_arg="--quiet"
fi

if [[ $install_globally -eq 1 ]]; then
  print "Installing (globally):"
  install --global $verbose_arg $quiet_arg
fi

if [[ $install_locally -eq 1 ]]; then
  print "Installing (locally):"
  install $verbose_arg $quiet_arg
fi

ROOT="$(git rev-parse --show-toplevel)"

exec_arg="nix build $ROOT#firmware --no-link"
if [[ $verbose -eq 1 ]]; then
  exec_arg="$exec_arg --print-build-logs"
fi

nodemon_cmd="nodemon '$verbose_arg' --watch '$ROOT/src' --exec '$exec_arg' --ext c,h,mk,json"
if [[ $quiet -eq 1 ]]; then
  nodemon_cmd="$nodemon_cmd 1> /dev/null"
fi

eval "$nodemon_cmd"
