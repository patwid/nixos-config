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
      overlays = {
        default = final: prev: {
          hello = final.callPackage ./nix/packages/hello.nix { };
        };
      };
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
        packages = with pkgs; {
          default = hello;
          inherit hello;
        };

        devShells = {
          default = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [ go ];
          };
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
