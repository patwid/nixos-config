{ lib, pkgs, ... }@attrs:
let
  localpkgs = import ../pkgs attrs;
in
{
  overlay =
    (self: super: {
      inherit (localpkgs)
        xdg-open
        jtt
        google-chrome
        notify-low-battery
        mattermost
        menu-run
        menu-pass
        outlook
        smartaz
        teams;
    });
}
