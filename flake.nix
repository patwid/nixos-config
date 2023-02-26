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
      specialArgs = attrs;
      modules = [ ./configuration.nix nur.nixosModules.nur ];
    };
    nixosConfigurations.htpc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix nur.nixosModules.nur ];
    };
  };
}
