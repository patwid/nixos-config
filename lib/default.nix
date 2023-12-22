{ lib }:
let
  filesystem = import ./filesystem.nix { inherit lib; };
in
{
  inherit (filesystem) modulesIn;

  colors = import ./colors.nix { inherit lib; };
}
