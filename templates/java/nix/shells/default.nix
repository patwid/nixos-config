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
    ln -sfT $JAVA_HOME ${binDir}/jdk21
  '';
}

