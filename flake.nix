{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-23.11;

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
                  let modulesIn = lib.modulesIn system; in
                  modulesIn ./hosts/${system}/${hostname} ++ modulesIn ./modules/nixos;
              };
          })
          (lib.attrNames (builtins.readDir ./hosts/${system})))
        systems);

      formatter = forEachSystem (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
    };
}
