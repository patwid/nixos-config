{
  lib,
  stdenv,
  fetchFromSourcehut,
  hare-gi,
  glib,
  gobject-introspection,
  gtk4,
  graphene,
  pango,
  gdk-pixbuf,
  harfbuzz,
  atk,
  gtk4-layer-shell,
}:

stdenv.mkDerivation {
  pname = "hare-gtk4-layer-shell";
  version = "0.1.0";

  src = fetchFromSourcehut {
    owner = "~sircmpwn";
    repo = "hare-gtk4-layer-shell";
    rev = "0.1.0";
    hash = "sha256-320TRtkZnaN0IY/RYyCnd+TEr5I+WBN5CWYTGb7covg=";
  };

  nativeBuildInputs = [ hare-gi ];

  postPatch =
    let
      girDirs = [
        "${glib.dev}/share/gir-1.0"
        "${gobject-introspection.dev}/share/gir-1.0"
        "${gtk4.dev}/share/gir-1.0"
        "${graphene.dev}/share/gir-1.0"
        "${pango.dev}/share/gir-1.0"
        "${gdk-pixbuf.dev}/share/gir-1.0"
        "${harfbuzz.dev}/share/gir-1.0"
        "${atk.dev}/share/gir-1.0"
        "${gtk4-layer-shell.dev}/share/gir-1.0"
      ];
    in
    ''
      girDir=$(mktemp -d)
      ${lib.concatMapStringsSep "\n" (d: "ln -sf ${d}/*.gir $girDir/") girDirs}
      substituteInPlace scripts/generate \
        --replace-fail '/usr/share/gir-1.0' "$girDir"
    '';

  installFlags = [ "PREFIX=${builtins.placeholder "out"}" ];

  meta = {
    homepage = "https://git.sr.ht/~sircmpwn/hare-gtk4-layer-shell";
    description = "Hare bindings for gtk4-layer-shell";
    license = lib.licenses.mpl20;
    maintainers = [ ];
    platforms = lib.platforms.linux;
  };
}
