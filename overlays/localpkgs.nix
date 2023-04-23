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
        mattermost
        menu-run
        menu-pass
        outlook
        smartaz
        teams;
    });
}
