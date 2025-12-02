{
  lib,
  stdenv,
  fetchFromSourcehut,
  desktop-file-utils,
  glib,
  gobject-introspection,
  gtk3,
  gtk-layer-shell,
  meson,
  ninja,
  pkg-config,
  python3,
  wrapGAppsHook3,
}:

let
  pname = "hiprompt-gtk-py";
in
stdenv.mkDerivation rec {
  inherit pname;
  version = "unstable-2022-12-21";

  src = fetchFromSourcehut {
    name = pname + "-src";
    owner = "~sircmpwn";
    repo = pname;
    rev = "8d6ef1d042ec2731f84245164094e622f4be3f2d";
    hash = "sha256-W2oDen9XkvoGOX9mshvUFBdkCGTr4SSTqQRDzayi2hc=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    glib
    meson
    ninja
    pkg-config
    wrapGAppsHook3
  ];

  buildInputs = [
    glib
    gobject-introspection
    gtk3
    gtk-layer-shell
    (python3.withPackages (
      pp: with pp; [
        pygobject3
      ]
    ))
  ];

  meta = {
    mainProgram = "hiprompt-gtk";
    homepage = "https://git.sr.ht/~sircmpwn/hiprompt-gtk-py";
    description = "A GTK+ Himitsu prompter for Wayland";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    platforms = lib.platforms.linux;
  };
}
