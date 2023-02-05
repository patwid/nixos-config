{
  description = "A passmenu";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    menu.url = path:/etc/nixos/pkgs/menu;
    menu.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, menu }:
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in {
        packages.x86_64-linux.passmenu = pkgs.stdenv.mkDerivation {
          pname = "passmenu";
          version = "1.0.0";
          src = ./passmenu.sh;

          dontUnpack = true;
          dontBuild = true;
          dontConfigure = true;

          installPhase = with pkgs; ''
            install -Dm 0755 $src $out/bin/passmenu
            wrapProgram $out/bin/passmenu --set PATH \
              "${
                lib.makeBinPath [
                  bash
                  coreutils
                  findutils
                  gnused
                  pass
                  wl-clipboard

                  menu.packages.x86_64-linux.menu
                ]
              }"
          '';

          nativeBuildInputs = with pkgs; [
            makeWrapper
          ];
        };

        packages.x86_64-linux.default = self.packages.x86_64-linux.passmenu;
    };
}
