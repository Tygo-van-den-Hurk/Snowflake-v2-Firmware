{
  description = "The flake used for building, checking and developing this school project.";

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
          config,
          pkgs,
          system,
          lib,
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

          apps.default = apps.flash;

          apps.flash = {
            type = "app";
            program = builtins.toString (
              pkgs.writeShellScript "flash" ''
                set -e

                export QMK_HOME="$(git rev-parse --show-toplevel)/qmk_firmware"

                wait_for() {
                  trap 'echo; echo "User interrupt"; exit 1' INT
                  printf "  waiting on $1 to appear"
                  while [ ! -e "$1" ]; do
                    printf "."
                    sleep 1.0
                  done
                  echo
                }

                echo "Flashing left first:"
                wait_for /dev/ttyACM0
                ${pkgs.avrdude}/bin/avrdude --verbose \
                  --part atmega32u4 \
                  --programmer avr109 \
                  --port /dev/ttyACM0 \
                  --baud 57600 \
                  --memory flash:w:${packages.firmware}/bin/firmware_left.hex:i \
                  --noerase 

                echo "Flash successful."
                sleep 3

                echo "Flashing right next:"
                wait_for /dev/ttyACM0
                ${pkgs.avrdude}/bin/avrdude --verbose \
                  --part atmega32u4 \
                  --programmer avr109 \
                  --port /dev/ttyACM0 \
                  --baud 57600 \
                  --memory flash:w:${packages.firmware}/bin/firmware_right.hex:i \
                  --noerase 

                echo "Flash successful."
              ''
            );
          };

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Develop ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

          devShells.default = pkgs.mkShell {

            shellHook = ''
              ${pre-commit-check.shellHook}
              export QMK_HOME="$(git rev-parse --show-toplevel)/qmk_firmware"
            '';

            buildInputs =
              pre-commit-check.enabledPackages
              ++ (with pkgs; [
                git-cliff # generate release notes.
                act # Run your GitHub Actions locally
                git # Distributed version control system
                qmk # Program to help users work with QMK Firmware
                avrdude # Command-line tool for programming Atmel AVR microcontrollers
              ]);
          };

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Build ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

          packages.default = packages.firmware;

          packages.firmware =
            with pkgs;
            stdenv.mkDerivation rec {
              name = "snowflake-v2-firmware";
              src = ./src;

              nativeBuildInputs = [ git ];
              buildInputs = [ qmk ];

              QMK_INTERACTIVE = "False";
              QMK_VERBOSE = "True";
              QMK_FIRMWARE = fetchFromGitHub rec {
                owner = "qmk";
                repo = "qmk_firmware";
                rev = "0.28.10";
                hash = "sha256-wov0r6PUEN9wbCHZOFe6n5sjBINu2dAzrzb7UNGaFBc=";
                fetchSubmodules = true;
                leaveDotGit = true;
              };

              keyboard = "snowflake/v2";
              keymap = "default";

              unpackPhase = ''
                runHook preUnpack

                echo "unpacking from ${QMK_FIRMWARE}"

                export HOME="$PWD"
                export QMK_HOME="$HOME/qmk_firmware"
                cp $QMK_FIRMWARE/ --recursive $QMK_HOME/

                chmod +rw $QMK_HOME/keyboards
                export QMK_FIRMWARE="$QMK_HOME"
                mkdir --parents "$QMK_HOME/keyboards/${keyboard}"
                cp ${src}/* --recursive "$QMK_HOME/keyboards/${keyboard}"

                chmod 777 $QMK_FIRMWARE --recursive
                cd $QMK_FIRMWARE

                runHook postUnpack
              '';

              configurePhase = ''
                runHook preConfigure
                # ...
                runHook postConfigure
              '';

              buildPhase = ''
                runHook preBuild         

                echo "Using qmk v$(qmk --version)"

                mkdir tmp

                qmk compile --clean \
                  --keyboard ${keyboard} \
                  --keymap ${keymap} \
                  --env handedness=left
                mv ./*.hex tmp/firmware_left.hex

                qmk compile --clean \
                  --keyboard ${keyboard} \
                  --keymap ${keymap} \
                  --env handedness=right
                mv ./*.hex tmp/firmware_right.hex

                runHook postBuild
              '';

              installPhase = ''
                runHook preInstall

                mkdir --parents $out/bin
                mv tmp/*.hex $out/bin

                runHook postInstall
              '';
            };

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
        };
    };
}
