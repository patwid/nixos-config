{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);
  localPkgs = rec {
    google-chrome = callPackage ./google-chrome { };
    hiprompt-gtk-py = callPackage ./hiprompt-gtk-py { };
    jtt = callPackage ./jtt { };
    mattermost = webapp.override { name = "mattermost"; url = "https://mattermost.ergon.ch/"; };
    menu = callPackage ./menu { };
    menu-feed = callPackage ./menu-feed { };
    menu-movies = menu-mpv.override { name = "movies"; dir = "~/videos/movies"; };
    menu-mpv = callPackage ./menu-mpv { };
    menu-music = menu-mpv.override { name = "music"; dir = "~/music/lossless"; depth = 2; };
    menu-news = menu-feed.override { name = "news"; opener = "xdg-open"; };
    menu-pass = callPackage ./menu-pass { };
    menu-podcasts = menu-feed.override { name = "podcasts"; opener = "mpv"; };
    menu-run = callPackage ./menu-run { };
    menu-shows = menu-mpv.override { name = "shows"; dir = "~/videos/tv_shows"; };
    menu-videos = menu-feed.override { name = "videos"; opener = "mpv"; };
    notify-low-battery = callPackage ./notify { name = "notify-low-battery"; summary = "Warning"; body = "Low Battery"; };
    outlook = webapp.override { name = "outlook"; url = "https://outlook.office.com/mail/"; };
    smartaz = webapp.override { name = "smartaz"; url = "https://smartaz.ergon.ch/"; };
    teams = webapp.override { name = "teams"; url = "https://teams.microsoft.com/"; };
    webapp = callPackage ./webapp { };
    whatsapp = webapp.override { name = "whatsapp"; url = "https://web.whatsapp.com/"; };
    xdg-open = callPackage ./xdg-open { };
    ytm = callPackage ./ytm { };
  };
in
lib.filterAttrs (n: _: ! builtins.elem n [ "menu" "menu-mpv" "menu-feed" "webapp" ]) localPkgs
