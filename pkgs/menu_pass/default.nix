{ lib, pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "menu_pass";
  version = "1.0.0";
  src = ./menu_pass.sh;

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = with pkgs; ''
    install -Dm 0755 $src $out/bin/menu_pass
    wrapProgram $out/bin/menu_pass --set PATH \
      "${
        lib.makeBinPath [
          bash
          coreutils
          findutils
          gnused
        ]
      }"
  '';
}
