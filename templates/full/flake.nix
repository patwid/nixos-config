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
          inherit (prev) hello;
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
          inherit hello;
          default = hello;
        };

        devShells = {
          default = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [ hello ];
          };
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
