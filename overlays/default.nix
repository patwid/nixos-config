{ lib, config, pkgs, nur }:
let
  localpkgs = import ./localpkgs.nix { inherit lib pkgs; };
  wmenu = import ./wmenu { inherit lib config pkgs; };
in
[
  nur.overlay
  localpkgs.overlay
  wmenu.overlay
]
