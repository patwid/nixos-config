{
  lib,
  stdenv,
  fetchFromSourcehut,
  hareHook,
}:

stdenv.mkDerivation {
  pname = "hare-ssh";
  version = "0-unstable-2026-04-19";

  src = fetchFromSourcehut {
    owner = "~sircmpwn";
    repo = "hare-ssh";
    rev = "b06bc3763b3105f0eb5a393e1dc182919bb633f2";
    hash = "sha256-msPY8m7/GDKsGDrhZ1IK65U+6fcI26FW9CONC4w87Pg=";
  };

  nativeBuildInputs = [ hareHook ];

  installFlags = [
    "PREFIX=${builtins.placeholder "out"}"
    "DESTDIR="
  ];

  meta = {
    homepage = "https://git.sr.ht/~sircmpwn/hare-ssh";
    description = "SSH library for Hare";
    license = lib.licenses.mpl20;
    inherit (hareHook.meta) platforms badPlatforms;
  };
}
