{ lib, pkgs, ... }@attrs:
let
  localpkgs = import ../pkgs attrs;
in
self: super: {
  inherit (localpkgs)
    xdg-open
    jtt
    google-chrome
    notify-low-battery
    mattermost
    menu-run
    menu-pass
    menu-news
    outlook
    smartaz
    teams
    hiprompt-gtk-py;
}
