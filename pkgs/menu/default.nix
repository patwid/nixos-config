{ lib, pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "menu";
  version = "1.0.0";
  src = ./menu.sh;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = with pkgs; ''
    install -Dm 0755 $src $out/bin/menu
    wrapProgram $out/bin/menu --set PATH \
      "${
        lib.makeBinPath [
          bash
          coreutils
          foot
          fzf
        ]
      }"
  '';
}
