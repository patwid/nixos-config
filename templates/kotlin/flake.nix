{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      overlays = {
        default = final: prev: {
          jdk = prev.jdk21;
          gradle = prev.gradle.override { java = final.jdk; };
          kotlin = prev.kotlin.override { jre = final.jdk; };
          hello = final.callPackage ./nix/pkgs/hello.nix { };
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {
        packages = with pkgs; {
          inherit hello;
          default = hello;
        };

        devShells = {
          default = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [
              gradle
              kotlin
            ];

            shellHook =
            let
              binDir = "~/.local/bin"
            in
            ''
              mkdir -p ${binDir}
              ln -sfT $JAVA_HOME ${binDir}/jdk21
            '';
          };
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
