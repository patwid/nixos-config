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
  libadwaita,
}:

stdenv.mkDerivation {
  pname = "hare-adwaita";
  version = "0.1.0";

  src = fetchFromSourcehut {
    owner = "~sircmpwn";
    repo = "hare-adwaita";
    rev = "0.1.0";
    hash = "sha256-E3nlBob3PmWNsfne5yA2qLYzWvrNVfDlMYnWBjYBQh4=";
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
        "${libadwaita.dev}/share/gir-1.0"
      ];
    in
    ''
      girDir=$(mktemp -d)
      ${lib.concatMapStringsSep "\n" (d: "ln -sf ${d}/*.gir $girDir/") girDirs}
      substituteInPlace scripts/generate \
        --replace-fail '/usr/share/gir-1.0' "$girDir"
    '';

  installFlags = [ "PREFIX=$(out)" ];

  meta = {
    homepage = "https://git.sr.ht/~sircmpwn/hare-adwaita";
    description = "Hare bindings for libadwaita";
    license = lib.licenses.mpl20;
    maintainers = [ ];
    platforms = lib.platforms.linux;
  };
}
