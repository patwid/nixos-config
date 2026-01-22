{
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  pname = "helix-theme-simple";
  version = "1.0.0";
  src = ./themes;
  installPhase = ''
    mkdir -p $out/lib/runtime/themes
    cp $src/simple.toml $out/lib/runtime/themes/
  '';
}
