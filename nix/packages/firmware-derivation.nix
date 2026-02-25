{
  pkgs,
  keymap,
  keyboard,
  self,
}:

with pkgs;

stdenv.mkDerivation rec {
  name = "snowflake-v4-firmware";
  src = "${self}/src";

  nativeBuildInputs = [ 
    git 
    python3
    python3Packages.hjson
    python3Packages.jsonschema
    python3Packages.pillow
  ];
  
  buildInputs = [
    qmk
    tree
    picotool
    gnumake
    python3
    gcc-arm-embedded-13
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

    cp -r ${QMK_FIRMWARE}/ $QMK_HOME/
    # Fix permissions BEFORE copying your files
    chmod -R +w $QMK_HOME

    mkdir -p "$QMK_HOME/keyboards/${keyboard}"
    cp -r ${src}/* "$QMK_HOME/keyboards/${keyboard}/"
    tree "$QMK_HOME/keyboards/${keyboard}"

    cd $QMK_FIRMWARE

    runHook postUnpack
  '';

  patchPhase = ''
    runHook prePatch

    ls -l "$QMK_FIRMWARE/util/"
    patchShebangs "$QMK_HOME/util/"
    
    runHook postPatch
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

    make VERBOSE=true ${keyboard}:${keymap}:all # || true
    # arm-none-eabi-objcopy -O ihex .build/snowflake_v4_default.elf .build/snowflake_v4_default.tmp 
    # ./util/uf2conv.py .build/snowflake_v4_default.tmp --output .build/snowflake_v4_default.uf2 --convert --family RP2040

    mv .build/*.uf2 tmp/firmware.uf2

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv tmp/*.uf2 $out/bin

    mkdir -p $out/share
    mv tmp/version $out/share/

    mkdir -p $out/share/docs
    cp ${src}/keymaps/default/keymap.c $out/share/docs/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Firmware for the Snowflake v4 keyboard";
    homepage = "https://github.com/Tygo-van-den-hurk/snowflake-v2-firmware";
    maintainers = with maintainers; [ Tygo-van-den-hurk ];
    license = with licenses; [ epl20 ];
  };
}
