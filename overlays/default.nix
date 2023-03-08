{ lib, pkgs, nur }:
[
  (import ./localpkgs.nix { inherit lib pkgs; })
  (import ./nur.nix { inherit nur; })
]
