{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@attrs: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs
      // {
        args = {
          user = "patwid";
          email = "patrick.widmer@tbwnet.ch";
          hostname = "laptop";
        };
      };
      modules = [
        home-manager.nixosModules.home-manager
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
          email = "patrick.widmer@tbwnet.ch";
          hostname = "htpc";
        };
      };
      modules = [
        home-manager.nixosModules.home-manager
        nur.nixosModules.nur
        ./configuration.nix
      ];
    };
  };
}
