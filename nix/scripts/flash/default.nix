_: {
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    let
      name = "flash";
      runtimeDependencies = with pkgs; [
        git
        bat
        avrdude
      ];
    in
    {
      packages.${name} = pkgs.stdenv.mkDerivation rec {
        inherit name;
        src = ./.;

        nativeBuildInputs =
          runtimeDependencies
          ++ (with pkgs; [
            makeWrapper
          ]);

        URL = "git+https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware#firmware";

        phases = "installPhase";
        installPhase = ''
          runHook preInstall

          mkdir --parents $out/share/bash-completion/completions
          cp ${src}/completions.bash $out/share/bash-completion/completions/${name}.bash

          mkdir --parents $out/bin
          cp ${src}/script.bash $out/bin/${name}
          patchShebangs $out/bin/${name}
          wrapProgram $out/bin/${name} --prefix PATH : ${lib.makeBinPath runtimeDependencies}

          runHook postInstall
        '';

        meta = with lib; {
          description = "Flash firmware to a Snowflake keyboard.";
          homepage = "https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware";
          license = with licenses; [ epl20 ];
          maintainers = with maintainers; [ Tygo-van-den-Hurk ];
        };
      };

      apps.${name} =
        let
          app = self'.packages.${name};
        in
        {
          program = "${toString app}/bin/${name}";
          inherit (app) meta;
        };
    };
}
