{ stdenv, requireFile, gradle, jdk17, makeWrapper, ... }:

let
  name = "jtt";
  version = "4.3.14";
  src = "${name}-${version}-dirty.tar";
  jdk = jdk17.override { enableJavaFX = true; };
in
stdenv.mkDerivation {
  pname = name;
  inherit version;

  src = requireFile {
    name = src;
    sha256 = "0a2cgig8nhxpij2jx0s8j03asw455aq9r0hqmsasf5iicci77yca";
    message = ''nix-prefetch-url file://\$PWD/${src}'';
  };

  nativeBuildInputs = [ gradle jdk makeWrapper ];

  buildPhase = ''
    mkdir -p $out/lib
    cp -a lib/*.jar $out/lib
  '';

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${jdk}/bin/java $out/bin/${name} \
      --add-flags "--add-exports=javafx.base/com.sun.javafx.event=ALL-UNNAMED" \
      --add-flags "--add-exports=javafx.controls/com.sun.javafx.scene.control=ALL-UNNAMED" \
      --add-flags "--add-exports=javafx.base/com.sun.javafx.collections=ALL-UNNAMED" \
      --add-flags "--add-opens=javafx.controls/javafx.scene.control.skin=ALL-UNNAMED" \
      --add-flags "-cp \"$out/lib/*\" ch.ergon.jtt.TableToolStarter" \
      --add-flags "--trace=3" \
      --add-flags "--no-update" \
      --add-flags "--enable-remotecontrol" \
      --add-flags "--database=ergon" \
      --add-flags "--server=sslsocket://ttshost.ergon.ch:5101"
  '';
}
