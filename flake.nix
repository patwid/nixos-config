{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations = builtins.listToAttrs (map
      (hostname: {
        name = hostname;
        value =
          let
            args = import ./hosts/${hostname}/args.nix // { inherit hostname; };
            paths = path: map (f: path + "/${f}") (builtins.attrNames (builtins.readDir path));
          in
          nixpkgs.lib.nixosSystem {
            inherit (args) system;
            specialArgs = attrs // { inherit args; };
            modules = [
              ./hosts/${hostname}/configuration.nix
              ./hosts/${hostname}/hardware-configuration.nix
            ] ++ paths ./modules;
          };
      })
      (builtins.attrNames (builtins.readDir ./hosts)));

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
