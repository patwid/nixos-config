{ stdenv, lib, makeWrapper, bash, coreutils, findutils, gnused, menu, pass, wl-clipboard, ... }:

stdenv.mkDerivation {
  pname = "menu-pass";
  version = "1.0.0";
  src = ./menu-pass.sh;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm 0755 $src $out/bin/menu-pass
    wrapProgram $out/bin/menu-pass --set PATH \
      "${
        lib.makeBinPath [
          bash
          coreutils
          findutils
          gnused
          menu
          pass
          wl-clipboard
        ]
      }"
  '';
}
