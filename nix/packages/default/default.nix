pkgs:

let

  firmware = "firmware/snowflake/v2/keymap/default";

in

pkgs.flake.${firmware}
