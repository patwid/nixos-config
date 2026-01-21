{
  lib,
  stdenv,
  gradle,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "hello";
  version = "0-unstable-2025-01-01";
  src = ../../.;

  nativeBuildInputs = [ gradle ];

  mitmCache = gradle.fetchDeps {
    inherit (finalAttrs) pname;
    data = ./deps.json;
  };

  gradleBuildTask = ":app:installDist";

  doCheck = true;

  installPhase = ''
    mkdir -p $out/{bin,lib}
    cp app/build/install/app/bin/app $out/bin/hello
    cp app/build/install/app/lib/*.jar $out/lib
  '';

  meta.sourceProvenance = with lib.sourceTypes; [
    fromSource
    binaryBytecode # mitm cache
  ];
})
