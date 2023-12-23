{ lib }:
let
  filesystem = import ./filesystem.nix { inherit lib; };
  colors = import ./colors.nix { inherit lib; };
in
{
  inherit (filesystem) modulesIn;
  inherit colors;
}
