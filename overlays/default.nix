{ lib, pkgs, nur }:
let
  localpkgs = import ./localpkgs.nix { inherit lib pkgs; };
  wmenu = import ./wmenu;
in
[
  nur.overlay
  localpkgs.overlay
  wmenu.overlay
]
