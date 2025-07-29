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
          hello = prev.dockerTools.buildLayeredImage {
            name = "hello";
            tag = "latest";
            contents = with prev; [ hello ];
            config.Cmd = with prev; [ "${hello}/bin/hello" ];
          };
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

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}
