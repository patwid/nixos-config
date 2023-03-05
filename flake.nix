{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@attrs: {
    nixosConfigurations.desktop =
      let
        hostname = "desktop";
      in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs
          // {
          args = {
            user = "patwid";
            email = "patrick.widmer@ergon.ch";
            inherit hostname;
          };
        };
        modules = [
          home-manager.nixosModules.home-manager
          nur.nixosModules.nur
          ./hosts/${hostname}
        ];
      };

    nixosConfigurations.cohen =
      let
        hostname = "cohen";
      in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs
          // {
          args = {
            user = "patwid";
            email = "patrick.widmer@ergon.ch";
            inherit hostname;
          };
        };
        modules = [
          home-manager.nixosModules.home-manager
          nur.nixosModules.nur
          ./hosts/${hostname}
        ];
      };

    nixosConfigurations.laptop =
      let
        hostname = "laptop";
      in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs
          // {
          args = {
            user = "patwid";
            email = "patrick.widmer@tbwnet.ch";
            inherit hostname;
          };
        };
        modules = [
          home-manager.nixosModules.home-manager
          nur.nixosModules.nur
          ./hosts/${hostname}
        ];
      };

    nixosConfigurations.htpc =
      let
        hostname = "htpc";
      in
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs
          // {
          args = {
            user = "patwid";
            email = "patrick.widmer@tbwnet.ch";
            inherit hostname;
          };
        };
        modules = [
          home-manager.nixosModules.home-manager
          nur.nixosModules.nur
          ./hosts/${hostname}
        ];
      };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
