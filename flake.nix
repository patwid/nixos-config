{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, nur, ... }@attrs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs
      // {
        args = {
          user = "patwid";
          hostname = "laptop";
        };
      };
      modules = [
        nur.nixosModules.nur
        ./configuration.nix
      ];
    };
    nixosConfigurations.htpc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs
      // {
        args = {
          user = "patwid";
          hostname = "htpc";
        };
      };
      modules = [
        nur.nixosModules.nur
        ./configuration.nix
      ];
    };
  };
}
