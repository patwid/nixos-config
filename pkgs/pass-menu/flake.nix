{
  description = "A pass-menu";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    menu.url = path:/etc/nixos/pkgs/menu;
    menu.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, menu }:
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in {
        packages.x86_64-linux.pass-menu = pkgs.stdenv.mkDerivation {
          pname = "pass-menu";
          version = "1.0.0";
          src = ./pass-menu.sh;

          dontUnpack = true;
          dontBuild = true;
          dontConfigure = true;

          installPhase = with pkgs; ''
            install -Dm 0755 $src $out/bin/pass-menu
            wrapProgram $out/bin/pass-menu --set PATH \
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

        packages.x86_64-linux.default = self.packages.x86_64-linux.pass-menu;
    };
}
