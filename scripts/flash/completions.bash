# shellcheck shell=bash

_x_flash_script_completions() {
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    case "$prev" in
        -b|--baud-rate)
            COMPREPLY=( $(compgen -W "9600 19200 38400 57600 115200" -- "$cur") )
            return 0
            ;;
        -s|--serial-device)
            COMPREPLY=( $(compgen -f -- "$cur") )
            return 0
            ;;
        -f|--firmware)
            COMPREPLY=( $(compgen -d -- "$cur") )
            return 0
            ;;
    esac

    # if [[ "$cur" == --serial-device=* || "$cur" == -s=* ]]; then
    #     local opts="--color=auto --color=never --color=always --colour=auto --colour=never --colour=always"
    #     COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
    #     return 0
    # fi
    
    if [[ "$cur" == --baud-rate=* || "$cur" == -b=* ]]; then
        local opts_long="--baud-rate=9600 --baud-rate=19200 --baud-rate=38400 --baud-rate=57600 --baud-rate=115200"
        local opts_short="-b=9600 -b=19200 -b=38400 -b=57600 -b=115200"
        COMPREPLY=( $(compgen -W "$opts_long $opts_short" -- "$cur") )
        return 0
    fi
    
    # suggest flags if current word starts with -
    local opts="-h --help -v --verbose -q --quiet -b -b= --baud-rate --baud-rate= -s -s= --serial-device --serial-device= -f -f= --firmware --firmware="
    COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
    return 0
}

complete -F _x_flash_script_completions flash
