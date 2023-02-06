{
  description = "A passmenu";

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.default = self.packages.x86_64-linux.menu_pass;
      packages.x86_64-linux.menu_pass = pkgs.stdenv.mkDerivation {
        pname = "menu_pass";
        version = "1.0.0";
        src = ./menu_pass.sh;

        dontUnpack = true;
        dontBuild = true;
        dontConfigure = true;

        installPhase = with pkgs; ''
          install -Dm 0755 $src $out/bin/menu_pass
          wrapProgram $out/bin/menu_pass --set PATH \
            "${
              lib.makeBinPath [
                bash
                coreutils
                findutils
                gnused
              ]
            }"
        '';

        nativeBuildInputs = [ pkgs.makeWrapper ];
      };
    };
}
