{ lib, pkgs, ... }@attrs:
let
  localpkgs = import ../pkgs attrs;
in
{
  overlay =
    (self: super: {
      inherit (localpkgs)
        # TODO: remove, https://nixpk.gs/pr-tracker.html?pr=226520
        xdg-desktop-portal-wlr

        xdg-open
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
