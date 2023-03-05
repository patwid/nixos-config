{ lib, pkgs }:
let
  localpkgs = import ../pkgs { inherit lib pkgs; };
in
(self: super: {
  xdg-open = localpkgs.xdg-open;
  zulu17 = localpkgs.zulu17;
  jtt = localpkgs.jtt;
  menu-run = localpkgs.menu-run;
  menu-pass = localpkgs.menu-pass;
  outlook = localpkgs.outlook;
  smartaz = localpkgs.smartaz;
  teams = localpkgs.teams;
})
