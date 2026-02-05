_:
{
  # Adds all packages as checks to the flake:
  perSystem =
    { self', lib, ... }:
    {
      checks = lib.mapAttrs (_name: value: value) self'.packages;
    };
}
