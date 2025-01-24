{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);
  localPkgs = {
    google-chrome = callPackage ./google-chrome { };
    hiprompt-gtk-py = callPackage ./hiprompt-gtk-py { };
    jtt = callPackage ./jtt { };
    menu = callPackage ./menu { };
    menu-feed = callPackage ./menu-feed { };
    menu-mpv = callPackage ./menu-mpv { };
    menu-pass = callPackage ./menu-pass { };
    menu-run = callPackage ./menu-run { };
    notify = callPackage ./notify { };
    webapp = callPackage ./webapp { };
    xdg-open = callPackage ./xdg-open { };
    ytm = callPackage ./ytm { };
  };
in
localPkgs
