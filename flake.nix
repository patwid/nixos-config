{
  description = "Personal NixOS configuration";

  inputs = {
    # Use this overlay as follows: pkgs.stable.<pkg-name>
    nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-23.05;

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
      inherit (nixpkgs) lib;

      systems = lib.attrNames (builtins.readDir ./hosts);
      forEachSystem = lib.genAttrs systems;
    in
    {
      nixosConfigurations = lib.listToAttrs (lib.concatMap
        (system: map
          (hostname: {
            name = hostname;
            value =
              let
                arch = lib.head (lib.splitString "-" system);
                isOptionalModule = path: lib.hasInfix "+" path;
                isArchModule = path: lib.hasInfix "+${arch}" path;
                shouldImportModule = path: !isOptionalModule path || isArchModule path;

                # XXX: this approach does not support import of directories
                # containing a default.nix file, e.g. dir/default.nix
                files = path: lib.filter (p: shouldImportModule (builtins.toString p))
                  (lib.filesystem.listFilesRecursive path);
              in
              lib.nixosSystem {
                inherit system;
                specialArgs = attrs // { inherit hostname; };
                lib = lib.extend (import ./lib);
                modules = files ./hosts/${system}/${hostname} ++ files ./modules;
              };
          })
          (lib.attrNames (builtins.readDir ./hosts/${system})))
        systems);

      formatter = forEachSystem (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
    };
}
