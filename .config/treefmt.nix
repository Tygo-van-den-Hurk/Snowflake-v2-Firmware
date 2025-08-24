_: {
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true; # nix formatting
    statix.enable = true; # nix static analysis
    deadnix.enable = true; # find dead nix code
    mdformat.enable = true; # markdown formatting
    clang-format.enable = true; # C formatting
  };

  settings.formatter.clang-format.excludes = [ "**/keymap.c" ];
}
