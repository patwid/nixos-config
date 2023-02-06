{
  description = "A menu";

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.default = self.packages.x86_64-linux.menu;
      packages.x86_64-linux.menu = pkgs.stdenv.mkDerivation {
        pname = "menu";
        version = "1.0.0";
        src = ./menu.sh;

        dontUnpack = true;
        dontBuild = true;
        dontConfigure = true;

        installPhase = with pkgs; ''
          install -Dm 0755 $src $out/bin/menu
          wrapProgram $out/bin/menu --set PATH \
            "${
              lib.makeBinPath [
                bash
                coreutils
                foot
                fzf
              ]
            }"
        '';

        nativeBuildInputs = [ pkgs.makeWrapper ];
      };
    };
}
