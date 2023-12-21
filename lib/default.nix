{ lib }:
let
  filesystem = import ./filesystem.nix { inherit lib; };
in
{
  inherit (filesystem) listModulesRecursively;

  colors = import ./colors.nix { inherit lib; };
}
