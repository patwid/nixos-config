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
              args = import ./hosts/${hostname}/+args.nix // { inherit hostname; };
              arch = builtins.head (nixpkgs.lib.strings.splitString "-" args.system);
              isOptionalModule = path: nixpkgs.lib.strings.hasInfix "+" path;
              isArchModule = path: nixpkgs.lib.strings.hasInfix "+${arch}" path;
              shouldImportModule = path: !isOptionalModule path || isArchModule path;
              files = path: builtins.filter (p: shouldImportModule (builtins.toString p)) (nixpkgs.lib.filesystem.listFilesRecursive path);
            in
            nixpkgs.lib.nixosSystem {
              inherit (args) system;
              specialArgs = attrs // { inherit args; };
              lib = nixpkgs.lib.extend (import ./lib);
              modules = files ./hosts/${hostname} ++ files ./modules;
            };
        })
        (builtins.attrNames (builtins.readDir ./hosts)));

      formatter = forEachSystem (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
    };
}
