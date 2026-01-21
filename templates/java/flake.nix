{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      inherit (nixpkgs) lib;
      eachDefaultSystem =
        f:
        lib.systems.flakeExposed
        |> map (s: lib.mapAttrs (_: v: { ${s} = v; }) (f s))
        |> lib.foldAttrs lib.mergeAttrs { };
    in
    {
      overlays =
        builtins.readDir ./nix/overlays
        |> lib.mapAttrs' (
          name: _:
          lib.nameValuePair (lib.removeSuffix ".nix" name) (import ./nix/overlays/${name} { inherit lib; })
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
        packages = pkgs // {
          default = pkgs.hello;
        };

        devShells =
          builtins.readDir ./nix/shells
          |> lib.mapAttrs' (
            name: _:
            lib.nameValuePair (lib.removeSuffix ".nix" name) (import ./nix/shells/${name} { inherit pkgs; })
          );

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
