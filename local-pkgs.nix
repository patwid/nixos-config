{ lib, pkgs, ... }:
let
  localPkgs = import ./pkgs { inherit lib pkgs; };
in {
  nixpkgs.overlays = [
    (self: super: {
        menu-run = localPkgs.menu-run;
        menu-pass = localPkgs.menu-pass;
        outlook = localPkgs.outlook;
        smartaz = localPkgs.smartaz;
        teams = localPkgs.teams;
    })
  ];
}
