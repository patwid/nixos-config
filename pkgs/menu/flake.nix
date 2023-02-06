{
  description = "A menu";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = self.packages.menu;
        packages.menu = pkgs.stdenv.mkDerivation {
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
      });
}
