{
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation {
  pname = "helix-theme-focus";
  version = "1.0.0";
  src = ./themes;
  installPhase = ''
    mkdir -p $out/lib/runtime/themes
    cp $src/focus.toml $out/lib/runtime/themes/
  '';
}
