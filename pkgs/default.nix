{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);
  localPkgs = {
    xdg-open = callPackage ./xdg-open { };
    jtt = callPackage ./jtt { };
    menu = callPackage ./menu { };
    menu-pass = callPackage ./menu-pass { };
    menu-run = callPackage ./menu-run { };
    menu-news = callPackage ./menu-feed { name = "news"; opener = "xdg-open"; };
    menu-videos = callPackage ./menu-feed { name = "videos"; opener = "mpv"; };
    menu-podcasts = callPackage ./menu-feed { name = "podcasts"; opener = "mpv"; };
    google-chrome = callPackage ./google-chrome { };
    outlook = callPackage ./webapp {
      name = "outlook";
      url = "https://outlook.office.com/mail/";
    };
    mattermost = callPackage ./webapp {
      name = "mattermost";
      url = "https://mattermost.ergon.ch/";
    };
    teams = callPackage ./webapp {
      name = "teams";
      url = "https://teams.microsoft.com/";
    };
    smartaz = callPackage ./webapp {
      name = "smartaz";
      url = "https://smartaz.ergon.ch/";
    };
    notify-low-battery = callPackage ./notify {
      name = "notify-low-battery";
      summary = "Warning";
      body = "Low Battery";
    };
    hiprompt-gtk-py = callPackage ./hiprompt-gtk-py { };
  };
in
localPkgs
