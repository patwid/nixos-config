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
    rev = "876d2b041c1146290e2198e6432eeb186236d677";
    hash = "sha256-/TKs3WPVqc8uHhhf8IRzh1smxKSzFK2KAd/uZHTiGkk=";
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
