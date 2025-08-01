{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
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
          lib.nameValuePair (lib.removeSuffix ".nix" name) (
            import ./overlays/${name} { inherit nixpkgs-stable lib; }
          )
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
              specialArgs = inputs // {
                inherit hostname;
              };
              modules =
                lib.modulesIn system ./hosts/${system}/${hostname}
                ++ lib.modulesIn system ./modules/nixos;
            }
          )
        )
        |> lib.mergeAttrsList;

      templates =
        {
          default = self.templates.full;
        }
        // builtins.readDir ./templates
        |> lib.mapAttrs (
          name: _: {
            description = name;
            path = ./templates/${name};
          }
        );
    }
    // eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {
        packages = pkgs;
        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
