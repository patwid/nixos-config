{ lib, pkgs }:
let
  localpkgs = import ../pkgs { inherit lib pkgs; };
in
{
  overlay =
    (self: super: {
      inherit (localpkgs)
        xdg-open
        xdg-desktop-portal-wlr
        jtt
        google-chrome
        mattermost
        menu-run
        menu-pass
        outlook
        smartaz
        teams;
    });
}
