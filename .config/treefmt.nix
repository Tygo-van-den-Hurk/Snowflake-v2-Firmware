_: {
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true; # nix formatting
    statix.enable = true; # nix static analysis
    deadnix.enable = true; # find dead nix code
    mdformat.enable = true; # markdown formatting
    clang-format.enable = true; # C formatting
    shfmt.enable = true; # Shell script formatting
    shellcheck.enable = true; # Shell script linting
  };

  settings.formatter.clang-format.excludes = [ "**/keymap.c" ];
  settings.formatter.shellcheck.excludes = [ "**/.envrc" ];
  settings.formatter.shfmt.excludes = [ "**/.envrc" ];
}
