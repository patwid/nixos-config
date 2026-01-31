{
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  pname = "helix-theme-focus";
  version = "1.0.0";
  src = ./src;
  installPhase = ''
    mkdir -p $out/lib/runtime/themes
    cp -r $src/* $out/lib/runtime/
  '';
}
