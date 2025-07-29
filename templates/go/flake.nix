{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      overlays = {
        default = final: prev: {
          hello = final.callPackage ./nix/packages/hello.nix { };
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
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
