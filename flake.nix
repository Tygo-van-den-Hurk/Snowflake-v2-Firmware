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

          qmk_firmware_version = "0.28.10";

          qmk_repo = pkgs.fetchFromGitHub rec {
            owner = "qmk";
            repo = "qmk_firmware";
            rev = qmk_firmware_version;
            hash = "sha256-JMvdyxqJNk+l9quEtQFz3kczi/hnJSy/a/fSkPG4WLQ=";
            fetchSubmodules = true;
          };

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

          apps.install = {
            type = "app";
            program = builtins.toString "${packages.install}/bin/install";
          };

          apps.flash = {
            type = "app";
            program = builtins.toString "${packages.flash}/bin/flash";
          };

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
                if package == "default" || package == "firmware" then
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

          packages.default = packages.firmware;

          packages.install = pkgs.callPackage ./scripts/install {
            version = qmk_firmware_version;
          };

          packages.flash = pkgs.callPackage ./scripts/flash { };

          packages.watch = pkgs.callPackage ./scripts/watch {
            inherit (packages) install;
            inherit (packages) flash;
          };

          packages.firmware =
            with pkgs;
            stdenv.mkDerivation rec {
              name = "snowflake-v2-firmware";
              src = ./src;

              nativeBuildInputs = [ git ];
              buildInputs = [
                qmk
                tree
              ];

              QMK_INTERACTIVE = "False";
              QMK_VERBOSE = "True";
              QMK_FIRMWARE = qmk_repo;

              keyboard = "snowflake/v2";
              keymap = "default";

              unpackPhase = ''
                runHook preUnpack

                echo "unpacking from ${QMK_FIRMWARE}"

                export HOME="$PWD"
                export QMK_HOME="$HOME/qmk_firmware"
                export QMK_FIRMWARE="$QMK_HOME"

                cp ${QMK_FIRMWARE}/ --recursive $QMK_HOME/
                chmod +rw $QMK_HOME/keyboards

                mkdir --parents "$QMK_HOME/keyboards/${keyboard}"
                cp ${src}/* --recursive "$QMK_HOME/keyboards/${keyboard}"
                tree "$QMK_HOME/keyboards/${keyboard}"

                chmod 777 $QMK_FIRMWARE --recursive
                cd $QMK_FIRMWARE

                runHook postUnpack
              '';

              configurePhase = ''
                runHook preConfigure

                # Since QMK checks the git repository status this has to be patched
                git config --global init.defaultBranch master
                git config --global core.safecrlf false
                git config --global user.email "dev@qmk.fm"
                git config --global user.name "QMK Developers"
                git init
                git remote add origin https://github.com/qmk/qmk_firmware.git
                git add .
                git commit --message="initial commit" --date="@0" --quiet

                runHook postConfigure
              '';

              buildPhase = ''
                runHook preBuild         

                echo "Using qmk v$(qmk --version)"

                mkdir tmp

                export FIRMWARE_VERSION="$(grep '#define FIRMWARE_VERSION' ${src}/config.h | awk -F'\"' '{print $2}')"
                echo "Key map version: $FIRMWARE_VERSION"
                echo $FIRMWARE_VERSION > tmp/version

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

                mkdir --parents $out/share
                mv tmp/version $out/share/

                mkdir --parents $out/share/docs
                cp ${src}/keymaps/default/keymap.c $out/share/docs/

                runHook postInstall
              '';
            };

          # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
        };
    };
}
