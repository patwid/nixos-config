{
  lib,
  stdenv,
  requireFile,
  gradle,
  jdk21,
  makeWrapper,
}:

let
  name = "jtt";
  version = "4.3.14";
  src = "${name}-${version}.tar";
  jdk = jdk21.override { enableJavaFX = true; };
in
stdenv.mkDerivation {
  pname = name;
  inherit version;

  src = requireFile {
    name = src;
    sha256 = "sha256-2H+RLCMWB9VBU86LwrcJP3oo2QZi1bWUGOqFEYNQZxM=";
    message = ''nix-prefetch-url file://\$PWD/${src}'';
  };

  nativeBuildInputs = [
    gradle
    jdk
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/lib
    cp -a lib/*.jar $out/lib
  '';

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${lib.getExe jdk} $out/bin/${name} \
      --add-flags "--add-exports=javafx.base/com.sun.javafx.event=ALL-UNNAMED" \
      --add-flags "--add-exports=javafx.controls/com.sun.javafx.scene.control=ALL-UNNAMED" \
      --add-flags "--add-exports=javafx.base/com.sun.javafx.collections=ALL-UNNAMED" \
      --add-flags "--add-opens=javafx.controls/javafx.scene.control.skin=ALL-UNNAMED" \
      --add-flags "-cp \"$out/lib/*\" ch.ergon.jtt.TableToolStarter" \
      --add-flags "--trace=3" \
      --add-flags "--no-update" \
      --add-flags "--enable-remotecontrol" \
      --add-flags "--database=ergon" \
      --add-flags "--server=sslsocket://ttshost.ergon.ch:5101" \
      --add-flags "--username=\"ERGON\patwid\""
  '';
}
