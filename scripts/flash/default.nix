{
  avrdude,
  stdenv,
  writeShellScriptBin,
  firmware,
}:
let
  script = writeShellScriptBin "flash" ''

    firmware="${firmware}"

    avrdude() {
      ${avrdude}/bin/avrdude "$@"
      return "$?"
    }

    ${builtins.readFile ./script.bash}
  '';
in

stdenv.mkDerivation rec {
  name = "flash";
  src = ./.;

  inherit script;

  buildPhase = ''
    runHook preBuild

    echo ${script}/bin/flash

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/bin
    cp ${script}/bin/flash $out/bin/flash

    mkdir --parents $out/share/bash-completion/completions
    cp $src/completions.bash $out/share/bash-completion/completions/flash.bash

    runHook postInstall
  '';
}
