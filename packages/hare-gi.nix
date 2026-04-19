{
  lib,
  stdenv,
  fetchFromSourcehut,
  hareHook,
  glib,
  gobject-introspection,
  gtk4,
  graphene,
  pango,
  gdk-pixbuf,
  harfbuzz,
  atk,
}:

stdenv.mkDerivation {
  pname = "hare-gi";
  version = "0-unstable-2025-08-02";

  src = fetchFromSourcehut {
    owner = "~yerinalexey";
    repo = "hare-gi";
    rev = "8e8a4a50227ba3e7bda74ada326fec686f15da86";
    hash = "sha256-L9BatUF+5SJhkFpzvjkDGMk2bSlQCv4ed2W5gJz6P+4=";
  };

  nativeBuildInputs = [ hareHook ];

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
      ];
    in
    ''
      girDir=$(mktemp -d)
      ${lib.concatMapStringsSep "\n" (d: "ln -sf ${d}/*.gir $girDir/") girDirs}
      substituteInPlace scripts/generate-gtk4 \
        --replace-fail '/usr/share/gir-1.0' "$girDir"
    '';

  buildPhase = ''
    runHook preBuild
    hare build $NIX_HAREFLAGS -o hare-gi cmd/hare-gi/
    ./scripts/generate-gtk4
    touch .gen
    runHook postBuild
  '';

  installFlags = [ "PREFIX=${builtins.placeholder "out"}" ];
  installTargets = [
    "install-core"
    "install-gtk-shared"
    "install-gtk4"
  ];

  postInstall = ''
    install -Dm755 hare-gi $out/bin/hare-gi
  '';

  meta = {
    homepage = "https://git.sr.ht/~yerinalexey/hare-gi";
    description = "GObject Introspection bindings for Hare";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    inherit (hareHook.meta) platforms badPlatforms;
  };
}
