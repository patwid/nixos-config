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
          hareThirdParty = prev.hareThirdParty.overrideScope (
            final': prev': {
              hello = final.callPackage ./nix/pkgs/hello.nix { };
            }
          );
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
          inherit (hareThirdParty) hello;
          default = hareThirdParty.hello;
        };

        devShells = {
          default = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [ hare ];
          };
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
