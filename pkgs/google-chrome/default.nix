{ stdenv, chromium, ... }:

let
  name = "google-chrome";
  version = "1.0.0";
in
stdenv.mkDerivation {
  pname = name;
  inherit version;

  src = ./.;

  nativeBuildInputs = [ chromium ];

  installPhase = ''
    mkdir -p $out/bin
    ln -s ${chromium}/bin/chromium $out/bin/${name}
  '';
}
