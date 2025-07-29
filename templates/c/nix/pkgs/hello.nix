{ stdenv }:
stdenv.mkDerivation {
  pname = "hello";
  version = "0-unstable-2025-01-01";
  src = ../../.;

  installFlags = [ "PREFIX=$(out)" ];
}
