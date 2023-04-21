{ lib, config, pkgs, nur }:
let
  localpkgs = import ./localpkgs.nix { inherit lib pkgs; };
  pass = import ./pass.nix;
  wmenu = import ./wmenu { inherit lib config pkgs; };
in
[
  nur.overlay
  localpkgs.overlay
  pass.overlay
  wmenu.overlay
]
