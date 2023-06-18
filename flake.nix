{
  description = "Personal NixOS configuration";

  inputs = {
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
      systems = [ "aarch64-linux" "x86_64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs systems;
    in
    {
      nixosConfigurations = builtins.listToAttrs (map
        (hostname: {
          name = hostname;
          value =
            let
              args = import ./hosts/${hostname}/args.nix // { inherit hostname; };
              files = path: map (f: path + "/${f}") (builtins.attrNames (nixpkgs.lib.attrsets.filterAttrs (_: type: type == "regular") (builtins.readDir path)));
              arch = nixpkgs.lib.strings.removeSuffix "-linux" args.system;
            in
            nixpkgs.lib.nixosSystem {
              inherit (args) system;
              specialArgs = attrs // { inherit args; };
              lib = nixpkgs.lib.extend (import ./lib);

              modules =
                [
                  ./hosts/${hostname}/configuration.nix
                  ./hosts/${hostname}/hardware-configuration.nix
                ]
                ++ files ./modules
                ++ nixpkgs.lib.optionals (builtins.pathExists (./modules + "/${arch}")) (files (./modules + "/${arch}"));
            };
        })
        (builtins.attrNames (builtins.readDir ./hosts)));

      formatter = forEachSystem (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
    };
}
