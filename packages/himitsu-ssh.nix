{
  lib,
  stdenv,
  fetchFromSourcehut,
  hareHook,
  hare-ssh,
  himitsu,
  hareThirdParty,
  scdoc,
}:

stdenv.mkDerivation {
  pname = "himitsu-ssh";
  version = "0-unstable-2026-04-19";

  src = fetchFromSourcehut {
    owner = "~sircmpwn";
    repo = "himitsu-ssh";
    rev = "71a8c151729842427eaeacc3d6793bb29cdb956e";
    hash = "sha256-3/JMA6nDY8i2tmGJNQ+yJtFByVucx7BypUN9ydlxuGo=";
  };

  nativeBuildInputs = [
    hareHook
    scdoc
  ];

  buildInputs = [
    hare-ssh
    hareThirdParty.hare-ev
    himitsu
  ];

  installFlags = [
    "PREFIX=${builtins.placeholder "out"}"
    "DESTDIR="
  ];

  meta = {
    mainProgram = "hissh-agent";
    homepage = "https://git.sr.ht/~sircmpwn/himitsu-ssh";
    description = "SSH integration for Himitsu";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    inherit (hareHook.meta) badPlatforms;
  };
}
