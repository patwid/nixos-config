{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
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
      systems = builtins.readDir ./hosts |> lib.attrNames;
      eachSystem =
        f:
        lib.foldAttrs lib.mergeAttrs { } (
          map (s: lib.mapAttrs (_: v: { ${s} = v; }) (f s)) lib.systems.flakeExposed
        );
    in
    {
      overlays = {
        default = import ./overlays { inherit nixpkgs-stable lib; };
      };

      nixosConfigurations =
        systems
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
    // eachSystem (
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
