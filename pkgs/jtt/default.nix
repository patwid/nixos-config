{ stdenv, requireFile, gradle, jdk17, makeWrapper, ... }:

let
  name = "jtt";
in
  stdenv.mkDerivation {
    pname = "${name}";
    version = "4.3.12-39";

    src = requireFile {
      name = "jtt-all-4.3.12-39-gcf4b0f5-dirty.jar";
      sha256 = "d4b37a5a099dbda557c7882804cfa091c7e09d249f0167ffeac366f4d3cbec45";

      message = ''
        nix-prefetch-url file://$\PWD/jtt-all-4.3.12-39-gcf4b0f5-dirty.jar
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
        --add-flags "--add-exports=javafx.base/com.sun.javafx.event=ALL-UNNAMED --add-exports=javafx.controls/com.sun.javafx.scene.control=ALL-UNNAMED --add-exports=javafx.base/com.sun.javafx.collections=ALL-UNNAMED --add-opens=javafx.controls/javafx.scene.control.skin=ALL-UNNAMED -jar $out/share/java/${name}.jar --trace=3 --no-update --enable-remotecontrol --database=ergon --server=sslsocket://ttshost.ergon.ch:5101"
    '';
  }
