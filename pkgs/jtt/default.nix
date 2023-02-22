{ stdenv, requireFile, gradle, jdk17, makeWrapper, ... }:

let
  name = "jtt";
  version = "4.3.12-39";
  src = "jtt-all-${version}-gcf4b0f5-dirty.jar";
in
  stdenv.mkDerivation {
    pname = "${name}";
    version = "${version}";

    src = requireFile {
      name = "${src}";
      sha256 = "d4b37a5a099dbda557c7882804cfa091c7e09d249f0167ffeac366f4d3cbec45";

      message = ''
        nix-prefetch-url file://$\PWD/${src}
      '';
    };

    dontUnpack = true;

    nativeBuildInputs = [ gradle jdk17 makeWrapper ];

    buildPhase = ''
      mkdir -p $out/share/java
      cp $src $out/share/java/${name}.jar
    '';

    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${jdk17}/bin/java $out/bin/${name} \
        --add-flags "--add-exports=javafx.base/com.sun.javafx.event=ALL-UNNAMED" \
        --add-flags "--add-exports=javafx.controls/com.sun.javafx.scene.control=ALL-UNNAMED" \
        --add-flags "--add-exports=javafx.base/com.sun.javafx.collections=ALL-UNNAMED" \
        --add-flags "--add-opens=javafx.controls/javafx.scene.control.skin=ALL-UNNAMED" \
        --add-flags "-jar $out/share/java/${name}.jar" \
        --add-flags "--trace=3" \
        --add-flags "--no-update" \
        --add-flags "--enable-remotecontrol" \
        --add-flags "--database=ergon" \
        --add-flags "--server=sslsocket://ttshost.ergon.ch:5101"
    '';
  }
