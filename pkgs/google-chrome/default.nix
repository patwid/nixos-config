{ stdenv, chromium, makeWrapper, ... }:

let
  name = "google-chrome";
  version = "1.0.0";
in
stdenv.mkDerivation {
  pname = name;
  inherit version;

  src = ./.;

  nativeBuildInputs = [ chromium makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${chromium}/bin/chromium $out/bin/${name}
  '';
}
