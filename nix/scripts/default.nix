pkgs:

with pkgs;

let
  contents = builtins.readDir ./.;
  directories = lib.filterAttrs (_name: type: type == "directory") contents;
in

builtins.mapAttrs (name: _value: import "${./.}/${name}" pkgs) directories
