{
  description = "The firmware for the 2nd version of the 'Snowflake' keyboard, build using QMK.";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-github-actions.url = "github:nix-community/nix-github-actions";

    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } rec {

      imports = [ ];

      systems = [
        "x86_64-linux"
      ];

      flake = {
        githubActions = inputs.nix-github-actions.lib.mkGithubMatrix {
          checks = inputs.nixpkgs.lib.getAttrs systems (
            # check whether the packages can be build for every platform,
            # but for linux also do the other checks. Prevents duplicated
            # checking for non-package builds.
            inputs.self.packages // { inherit (inputs.self.checks) x86_64-linux; }
          );
        };
      };

      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        let

          inherit (inputs) treefmt-nix pre-commit-hooks;

          treefmtEval = treefmt-nix.lib.evalModule pkgs ./.config/treefmt.nix;
          pre-commit-check = pre-commit-hooks.lib.${system}.run (import ./.config/pre-commit.nix);
        in
        rec {
          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Flake Check ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

          checks = packages // {
            formatting = treefmtEval.config.build.check inputs.self;
            inherit pre-commit-check;
          };

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Fmt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

          formatter = treefmtEval.config.build.wrapper;

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Run ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

          apps =
            let
              scripts = import ./nix/scripts pkgs;
            in
            builtins.mapAttrs (name: script: {
              type = "app";
              program = "${builtins.toString script}/bin/${name}";
              inherit (script) meta;
            }) scripts;

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Develop ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

          devShells.default = pkgs.mkShell {

            shellHook = ''
              ${pre-commit-check.shellHook}
              export QMK_HOME="$(git rev-parse --show-toplevel)/qmk_firmware"

              if [ -f .env ]; then
                source .env
              fi
            '';

            pure = true;

            buildInputs =
              pre-commit-check.enabledPackages
              ++ (map (
                package:
                if package == "default" || pkgs.lib.hasPrefix "firmware" package then
                  null
                else
                  inputs.self.packages.${system}.${package}
              ) (builtins.attrNames packages))
              ++ (with pkgs; [
                git-cliff # generate release notes.
                act # Run your GitHub Actions locally
                git # Distributed version control system
                qmk # Program to help users work with QMK Firmware
                minicom # Program to interact with serial devices
                avrdude # Command-line tool for programming Atmel AVR microcontrollers
              ]);
          };

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Build ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

          packages = import ./nix/packages pkgs;

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
        };
    };
}
