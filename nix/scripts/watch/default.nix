_: {
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    let
      name = "watch";
      runtimeDependencies = (with pkgs; [
        nodemon
        git
      ]) ++ (with self'.packages; [
        install
      ]);
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

        meta = {
          description = "Watch for changes in the source code and automatically recompile the Snowflake firmware.";
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
