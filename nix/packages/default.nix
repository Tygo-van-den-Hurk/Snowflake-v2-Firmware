{ ... }:
{
  imports = [
    ./firmware.nix
  ];

  # Assign default package output to the default keymap firmware:
  perSystem =
    { self', ... }:
    let
      keyboard = "snowflake/v2";
      keymap = "default";
      default = "${keyboard}@${keymap}";
    in
    {
      packages.default = self'.packages.${default};
    };
}
