{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    wrappers.url = "github:birdeehub/nix-wrapper-modules";
    wrappers.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";
    nix-jetbrains-plugins.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;

      eachDefaultSystem =
        f:
        lib.systems.flakeExposed
        |> map (s: lib.mapAttrs (_: v: { ${s} = v; }) (f s))
        |> lib.foldAttrs lib.mergeAttrs { };
    in
    {
      lib =
        builtins.readDir ./lib
        |> lib.mapAttrs' (
          name: _: lib.nameValuePair (lib.removeSuffix ".nix" name) (import ./lib/${name} lib)
        );

      overlays =
        builtins.readDir ./overlays
        |> lib.filterAttrs (name: _: !lib.hasPrefix "_" name)
        |> lib.mapAttrs' (
          name: _:
          lib.nameValuePair (lib.removeSuffix ".nix" name) (import ./overlays/${name} { inherit inputs lib; })
        );

      nixosConfigurations =
        builtins.readDir ./modules/hosts
        |> lib.attrNames
        |> map (
          system:
          builtins.readDir ./modules/hosts/${system}
          |> lib.mapAttrs' (hostname: v: lib.nameValuePair (lib.removePrefix "+" hostname) v)
          |> lib.mapAttrs (
            hostname: _:
            lib.nixosSystem {
              specialArgs = {
                inherit inputs;
              };
              modules = [
                { networking.hostName = hostname; }
              ]
              ++ (
                self.nixosModules
                |> lib.filterAttrs (
                  name: _:
                  lib.path.subpath.components name
                  |> lib.all (
                    component:
                    !lib.hasPrefix "+" component || lib.hasPrefix component "+${system}" || component == "+${hostname}"
                  )
                )
                |> builtins.attrValues
              );
            }
          )
        )
        |> lib.mergeAttrsList;

      nixosModules =
        lib.filesystem.listFilesRecursive ./modules
        |> lib.filter (lib.hasSuffix ".nix")
        |> map (path: lib.path.removePrefix ./modules path)
        |> lib.filter (
          path: lib.path.subpath.components path |> lib.all (component: !lib.hasPrefix "_" component)
        )
        |> map (name: {
          name = lib.removeSuffix ".nix" name;
          value = ./modules/${name};
        })
        |> lib.listToAttrs;

      homeModules =
        lib.filesystem.listFilesRecursive ./modules/_home-manager
        |> lib.filter (lib.hasSuffix ".nix")
        |> map (path: lib.path.removePrefix ./modules/_home-manager path)
        |> map (name: {
          name = lib.removeSuffix ".nix" name;
          value = ./modules/_home-manager/${name};
        })
        |> lib.listToAttrs;

      templates =
        (
          builtins.readDir ./templates
          |> lib.mapAttrs (
            name: _: {
              description = name;
              path = ./templates/${name};
            }
          )
        )
        // {
          default = self.templates.full;
        };
    }
    // eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = builtins.attrValues self.overlays;
        };
      in
      {
        packages =
          pkgs
          |> lib.filterAttrs (
            name: _:
            builtins.elem name (
              self.overlays
              |> lib.filterAttrs (name: _: name != "apple-silicon")
              |> lib.mapAttrsToList (_: overlay: overlay { } { })
              |> builtins.foldl' (a: b: a // b) { }
              |> builtins.attrNames
            )
          );

        formatter = pkgs.nixfmt;
      }
    );
}
