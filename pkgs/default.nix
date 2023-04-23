{ pkgs, lib, ... }:

let
  callPackage = lib.callPackageWith (pkgs // localPkgs);
  localPkgs = {
    xdg-open = callPackage ./xdg-open { };
    jtt = callPackage ./jtt { };
    menu = callPackage ./menu { };
    menu-pass = callPackage ./menu-pass { };
    menu-run = callPackage ./menu-run { };
    outlook = callPackage ./webapp {
      app = "outlook";
      url = "https://outlook.office.com/mail/";
    };
    mattermost = callPackage ./webapp {
      app = "mattermost";
      url = "https://mattermost.ergon.ch/";
    };
    teams = callPackage ./webapp {
      app = "teams";
      url = "https://teams.microsoft.com/";
    };
    smartaz = callPackage ./webapp {
      app = "smartaz";
      url = "https://smartaz.ergon.ch/";
    };
  };
in
localPkgs
