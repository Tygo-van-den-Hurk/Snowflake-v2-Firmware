_: {
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    let
      name = "install";
      runtimeDependencies = with pkgs; [ git ];
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
          description = "Clone the required repositories so that Snowflake firmware can be build the normal QMK way.";
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
