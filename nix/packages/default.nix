pkgs:

with pkgs;

let
  contents = builtins.readDir ./.;
  directories = lib.filterAttrs (_name: type: type == "directory") contents;
in

# creates all the "/firmware/${keyboard}/keymap/${keymap}" derivations
(import ./firmware.nix pkgs)

# creates all the other derivations in their own sub-directories
// builtins.mapAttrs (name: _value: import "${./.}/${name}" pkgs) directories
