{
  lib,
  stdenv,
  fetchFromSourcehut,
  hareHook,
  hare-gi,
  hare-adwaita,
  hare-gtk4-layer-shell,
  himitsu,
  glib,
  gtk4,
  libadwaita,
  gtk4-layer-shell,
  pkg-config,
}:

stdenv.mkDerivation {
  pname = "hiprompt-gtk";
  version = "0-unstable-2026-02-13";

  src = fetchFromSourcehut {
    owner = "~sircmpwn";
    repo = "hiprompt-gtk";
    rev = "74e795a692dec34bf14607c6abe02dce4e564a18";
    hash = "sha256-YNOI3uhQtdXX90k5gmpT7vwC49AOuTt/ae6mHjO2Bgw=";
  };

  nativeBuildInputs = [
    hareHook
    pkg-config
    glib # glib-compile-resources
  ];

  buildInputs = [
    hare-gi
    hare-adwaita
    hare-gtk4-layer-shell
    himitsu
    gtk4
    libadwaita
    gtk4-layer-shell
  ];

  # Hare's QBE backend emits non-PIC code on aarch64. GCC defaults to PIE
  # (--enable-default-pie), which requires PIC-compatible relocations.
  postPatch = lib.optionalString stdenv.hostPlatform.isAarch64 ''
    substituteInPlace Makefile \
      --replace-fail 'LDFLAGS="-Wl,--export-dynamic"' 'LDFLAGS="-no-pie -Wl,--export-dynamic"'
  '';

  installFlags = [
    "PREFIX=${builtins.placeholder "out"}"
    "DESTDIR="
  ];

  meta = {
    mainProgram = "hiprompt-gtk";
    homepage = "https://git.sr.ht/~sircmpwn/hiprompt-gtk";
    description = "A GTK4 Himitsu prompter for Wayland";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    inherit (hareHook.meta) badPlatforms;
  };
}
