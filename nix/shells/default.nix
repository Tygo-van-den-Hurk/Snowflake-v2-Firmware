_: {
  perSystem =
    { pkgs, config, ... }:
    let
      pure = true;

      formatters = builtins.attrValues config.treefmt.build.programs;
      hooks = config.pre-commit.settings.enabledPackages;
      packages = with pkgs; [
        git-cliff # generate release notes.
        act # Run your GitHub Actions locally
        git # Distributed version control system
        qmk # Program to help users work with QMK Firmware
        minicom # Program to interact with serial devices
        avrdude # Command-line tool for programming Atmel AVR microcontrollers
      ];

      buildInputs = packages ++ formatters ++ hooks;

      shellHook = ''
        ${config.pre-commit.shellHook}

        export QMK_HOME="$(git rev-parse --show-toplevel)/qmk_firmware"

        if [ -f .env ]; then
          source .env
        fi
      '';
    in
    {
      devShells.default = pkgs.mkShell {
        inherit buildInputs;
        inherit shellHook;
        inherit pure;
      };
    };
}
