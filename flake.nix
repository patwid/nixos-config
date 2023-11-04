{
  description = "Personal NixOS configuration";

  inputs = {
    # nixpkgs-stable.url = github:NixOS/nixpkgs/nixos-23.05;

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
      inherit (builtins)
        attrNames
        filter
        head
        listToAttrs
        readDir
        toString;

      systems = [ "aarch64-linux" "x86_64-linux" ];
      forEachSystem = lib.genAttrs systems;
    in
    {
      nixosConfigurations = listToAttrs (map
        (hostname: {
          name = hostname;
          value =
            let
              inherit (import ./hosts/${hostname}/+system.nix) system;
              arch = head (lib.strings.splitString "-" system);
              isOptionalModule = path: lib.strings.hasInfix "+" path;
              isArchModule = path: lib.strings.hasInfix "+${arch}" path;
              shouldImportModule = path: !isOptionalModule path || isArchModule path;

              # XXX: this approach does not support import of directories
              # containing a default.nix file, e.g. dir/default.nix
              files = path: filter (p: shouldImportModule (toString p)) (lib.filesystem.listFilesRecursive path);
            in
            lib.nixosSystem {
              inherit system;
              specialArgs = attrs // { inherit hostname; };
              lib = lib.extend (import ./lib);
              modules = files ./hosts/${hostname} ++ files ./modules;
            };
        })
        (attrNames (readDir ./hosts)));

      formatter = forEachSystem (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
    };
}
