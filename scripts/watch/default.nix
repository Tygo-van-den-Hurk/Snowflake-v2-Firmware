{
  stdenv,
  writeShellScriptBin,
  git,
  nodemon,
  install,
  flash,
}:
let
  script = writeShellScriptBin "watch" ''

    git() {
      ${git}/bin/git "$@"
      return "$?"
    }

    nodemon() {
      ${nodemon}/bin/nodemon "$@"
      return "$?"
    }

    install() {
      ${install}/bin/install "$@"
      return "$?"
    }

    flash() {
      ${flash}/bin/flash "$@"
      return "$?"
    }

    ${builtins.readFile ./script.bash}
  '';
in

stdenv.mkDerivation rec {
  name = "watch";
  src = ./.;

  inherit script;

  buildPhase = ''
    runHook preBuild

    echo ${script}/bin/watch

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/bin
    cp ${script}/bin/watch $out/bin/watch

    mkdir --parents $out/share/bash-completion/completions
    cp $src/completions.bash $out/share/bash-completion/completions/watch.bash

    runHook postInstall
  '';
}
