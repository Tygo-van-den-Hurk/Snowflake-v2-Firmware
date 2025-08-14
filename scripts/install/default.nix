{
  git,
  stdenv,
  writeShellScriptBin,
  version,
}:
let
  script = writeShellScriptBin "install" ''

    export VERSION="${version}"

    git() {
      ${git}/bin/git "$@"
      return "$?"
    }

    ${builtins.readFile ./script.bash}
  '';
in

stdenv.mkDerivation rec {
  name = "install";
  src = ./.;

  inherit script;

  buildPhase = ''
    runHook preBuild

    echo ${script}/bin/install

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir --parents $out/bin
    cp ${script}/bin/install $out/bin/install

    mkdir --parents $out/share/bash-completion/completions
    cp $src/completions.bash $out/share/bash-completion/completions/install.bash

    runHook postInstall
  '';
}
