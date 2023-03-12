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
        value = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            ./hosts/${hostname}/configuration.nix
            ./hosts/${hostname}/hardware-configuration.nix
            ./hosts/${hostname}/user.nix
            ./hosts/${hostname}/hostname.nix
          ];
        };
      })
      (builtins.attrNames (builtins.readDir ./hosts)));

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
