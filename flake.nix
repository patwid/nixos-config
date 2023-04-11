{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, nur, ... }@attrs: {
    nixosConfigurations = builtins.listToAttrs (map
      (hostname: {
        name = hostname;
        value =
          let
            args = import  ./hosts/${hostname}/args.nix // { inherit hostname; };
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = attrs // { inherit args; };
            modules = [
              ./hosts/${hostname}/configuration.nix
              ./hosts/${hostname}/hardware-configuration.nix
              ./modules
            ];
          };
      })
      (builtins.attrNames (builtins.readDir ./hosts)));

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
