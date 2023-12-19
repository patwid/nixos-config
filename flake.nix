{
  description = "Personal NixOS configuration";

  inputs = {
    # Use this overlay as follows: pkgs.stable.<pkg-name>
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-23.05;

    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    nixos-hardware.url = github:NixOS/nixos-hardware;

    nixos-apple-silicon.url = github:tpwrules/nixos-apple-silicon;
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, ... }@attrs:
    let
      lib = nixpkgs.lib.extend (import ./lib);
      systems = lib.attrNames (builtins.readDir ./hosts);
      forEachSystem = lib.genAttrs systems;
    in
    {
      nixosConfigurations = lib.listToAttrs (lib.concatMap
        (system: map
          (hostname: {
            name = hostname;
            value =
              lib.nixosSystem {
                inherit system lib;
                specialArgs = attrs // { inherit hostname; };

                modules =
                  lib.listModulesRecursively
                    {
                      inherit system;
                      path = ./hosts/${system}/${hostname};
                    } ++
                  lib.listModulesRecursively {
                    inherit system;
                    path = ./modules/nixos;
                  };
              };
          })
          (lib.attrNames (builtins.readDir ./hosts/${system})))
        systems);

      formatter = forEachSystem (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
    };
}
