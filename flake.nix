{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, nur, ... }@attrs: {
    nixosConfigurations = builtins.mapAttrs
      (hostname: { system, args }: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs // { inherit args; };
        modules = [
          nur.nixosModules.nur
          ./hosts/${hostname}/configuration.nix
        ];
      })
      (builtins.listToAttrs (map
        ({ args, ... }@config: {
          name = args.hostname;
          value = config;
        })
        (import ./hosts)));

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
