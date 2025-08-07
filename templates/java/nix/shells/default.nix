{ pkgs }:
pkgs.mkShellNoCC {
  buildInputs = with pkgs; [
    gradle
    jdk
  ];

  shellHook =
  let
    binDir = "~/.local/bin";
  in
  ''
    mkdir -p ${binDir}
    ln -sfT $JAVA_HOME ${binDir}/${pkgs.jdk.pname}${lib.versions.major pkgs.jdk.version}
  '';
}

