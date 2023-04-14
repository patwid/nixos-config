{ lib, pkgs }:
let
  localpkgs = import ../pkgs { inherit lib pkgs; };
in
(self: super: {
  inherit (localpkgs)
    xdg-open
    jtt
    google-chrome
    mattermost
    menu-run
    menu-pass
    outlook
    smartaz
    teams;
})
