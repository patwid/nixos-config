{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);
  localPkgs = {
    google-chrome = callPackage ./google-chrome { };
    hiprompt-gtk-py = callPackage ./hiprompt-gtk-py { };
    jtt = callPackage ./jtt { };
    mattermost = callPackage ./webapp { name = "mattermost"; url = "https://mattermost.ergon.ch/"; };
    menu = callPackage ./menu { };
    menu-news = callPackage ./menu-feed { name = "news"; opener = "xdg-open"; };
    menu-pass = callPackage ./menu-pass { };
    menu-podcasts = callPackage ./menu-feed { name = "podcasts"; opener = "mpv"; };
    menu-run = callPackage ./menu-run { };
    menu-videos = callPackage ./menu-feed { name = "videos"; opener = "mpv"; };
    notify-low-battery = callPackage ./notify { name = "notify-low-battery"; summary = "Warning"; body = "Low Battery"; };
    outlook = callPackage ./webapp { name = "outlook"; url = "https://outlook.office.com/mail/"; };
    smartaz = callPackage ./webapp { name = "smartaz"; url = "https://smartaz.ergon.ch/"; };
    teams = callPackage ./webapp { name = "teams"; url = "https://teams.microsoft.com/"; };
    whatsapp = callPackage ./webapp { name = "whatsapp"; url = "https://web.whatsapp.com/"; };
    xdg-open = callPackage ./xdg-open { };
  };
in
lib.filterAttrs (n: _: n != "menu") localPkgs
