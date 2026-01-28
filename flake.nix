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
      lib = nixpkgs.lib.extend (import ./lib);
      eachDefaultSystem =
        f:
        lib.systems.flakeExposed
        |> map (s: lib.mapAttrs (_: v: { ${s} = v; }) (f s))
        |> lib.foldAttrs lib.mergeAttrs { };
    in
    {
      overlays =
        builtins.readDir ./overlays
        |> lib.mapAttrs' (
          name: _:
          lib.nameValuePair (lib.removeSuffix ".nix" name) (import ./overlays/${name} { inherit inputs lib; })
        );

      nixosConfigurations =
        builtins.readDir ./hosts
        |> lib.attrNames
        |> map (
          system:
          builtins.readDir ./hosts/${system}
          |> lib.mapAttrs (
            hostname: _:
            lib.nixosSystem {
              inherit lib;
              specialArgs = {
                inherit inputs;
              };
              modules = [
                { networking.hostName = hostname; }
              ]
              ++ lib.filesystem.modulesIn system ./hosts/${system}/${hostname}
              ++ lib.filesystem.modulesIn system ./modules/nixos;
            }
          )
        )
        |> lib.mergeAttrsList;

      templates =
        (
          builtins.readDir ./templates
          |> lib.filterAttrs (name: _: name != ".gitignore")
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
        overlays = builtins.attrValues self.overlays;

        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      {
        packages =
          pkgs
          |> lib.filterAttrs (
            name: _:
            builtins.elem name (
              overlays
              |> map (overlay: overlay { } { })
              |> builtins.foldl' (a: b: a // b) { }
              |> builtins.attrNames
            )
          );

        formatter = pkgs.nixfmt;
      }
    );
}
