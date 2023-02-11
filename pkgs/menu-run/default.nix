{ stdenv, lib, makeWrapper, bash, coreutils, dmenu, findutils, menu, sway, ... }:

stdenv.mkDerivation {
  pname = "menu-run";
  version = "1.0.0";
  src = ./menu-run.sh;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm 0755 $src $out/bin/menu-run
    wrapProgram $out/bin/menu-run --set PATH \
      "${
        lib.makeBinPath [
          bash
          coreutils # dmenu_path depends on cat
          dmenu
          findutils
          menu
          sway
        ]
      }"
  '';
}
