pkgs:

with pkgs;

let
  self = ../..;
  keyboard = "snowflake/v2";
  contents = builtins.readDir "${self}/src/keymaps";
  keymaps = lib.filterAttrs (_name: type: type == "directory") contents;
in

lib.mapAttrs' (keymap: _value: {
  name = "firmware/${keyboard}/keymap/${keymap}";
  value = callPackage ./firmware-derivation.nix {
    inherit keyboard;
    inherit keymap;
    inherit self;
  };
}) keymaps
