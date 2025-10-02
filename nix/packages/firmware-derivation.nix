{
  pkgs,
  keymap,
  keyboard,
  self,
}:

with pkgs;

stdenv.mkDerivation rec {
  name = "snowflake-v2-firmware";
  src = "${self}/src";

  nativeBuildInputs = [ git ];
  buildInputs = [
    qmk
    tree
  ];

  QMK_INTERACTIVE = "False";
  QMK_VERBOSE = "True";
  QMK_FIRMWARE = pkgs.fetchFromGitHub rec {
    owner = "qmk";
    repo = "qmk_firmware";
    rev = "0.28.10";
    hash = "sha256-JMvdyxqJNk+l9quEtQFz3kczi/hnJSy/a/fSkPG4WLQ=";
    fetchSubmodules = true;
  };

  inherit keyboard;
  inherit keymap;

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
}
