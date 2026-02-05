{ ... }:
{
  imports = [
    ./flash
    ./install
    ./watch
  ];

  perSystem =
    {
      self',
      ...
    }:
    {
      apps.default = self'.apps."flash";
    };
}
