{
  git,
  avrdude,
  stdenv,
  bat,
  writeShellScriptBin,
}:

stdenv.mkDerivation rec {
  name = "flash";
  src = ./.;

  url = "git+https://github.com/Tygo-van-den-Hurk/Snowflake-v2-Firmware#firmware";
  script = writeShellScriptBin "flash" ''

    URL="${url}"

    avrdude() {
      ${avrdude}/bin/avrdude "$@"
      return "$?"
    }

    git() {
      ${git}/bin/git "$@"
      return "$?"
    }

    cat() {
      ${bat}/bin/bat "$@"
      return "$?"
    }

    ${builtins.readFile ./script.bash}
  '';

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
