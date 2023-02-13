{ stdenv, lib, makeWrapper, aerc, bash, imv, mpv, qutebrowser, zathura, ... }:

stdenv.mkDerivation {
  pname = "xdg-open";
  version = "1.0.0";
  src = ./xdg-open.sh;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm 0755 $src $out/bin/xdg-open
    wrapProgram $out/bin/xdg-open --set PATH \
      "${
        lib.makeBinPath [
          aerc
          bash
          imv
          mpv
          qutebrowser
          zathura
        ]
      }"
  '';
}
