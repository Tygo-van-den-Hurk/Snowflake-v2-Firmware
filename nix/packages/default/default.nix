pkgs:

let

  firmware = "firmware/snowflake/v4/keymap/default";

in

pkgs.flake.${firmware}
