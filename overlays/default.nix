{ inputs, lib, ... }:
final: prev:
let
  inherit (inputs) nixpkgs-stable;

  localpkgs = import ../packages {
    inherit lib;
    pkgs = final;
  };

  stable = import nixpkgs-stable {
    inherit (prev) config;
    inherit (prev.stdenv.hostPlatform) system;
  };
in
localpkgs
// {
  inherit stable;
  inherit (stable) teleport_16;

  menu-news = final.menu-feed.override {
    name = "news";
    opener = final.xdg-open;
  };
  menu-podcasts = final.menu-feed.override {
    name = "podcasts";
    opener = prev.mpv;
  };
  menu-videos = final.menu-feed.override {
    name = "videos";
    opener = prev.mpv;
  };

  menu-movies = final.menu-mpv.override {
    name = "movies";
    path = "~/videos/movies";
  };
  menu-music = final.menu-mpv.override {
    name = "music";
    path = "~/music";
  };
  menu-shows = final.menu-mpv.override {
    name = "shows";
    path = "~/videos/tv_shows";
  };

  _1password = final.webapp.override {
    name = "1password";
    url = "https://ergon.1password.eu";
  };
  mattermost = final.webapp.override {
    name = "mattermost";
    url = "https://mattermost.ergon.ch";
  };
  medbase = final.webapp.override {
    name = "medbase";
    url = "https://post.sa-portal.ch";
  };
  outlook = final.webapp.override {
    name = "outlook";
    url = "https://outlook.office.com/mail";
  };
  rds = final.webapp.override {
    name = "rds";
    url = "https://rds.ergon.ch";
  };
  sanacare = final.webapp.override {
    name = "sanacare";
    url = "https://sanacare.cloud.com";
  };
  smartaz = final.webapp.override {
    name = "smartaz";
    url = "https://smartaz.ergon.ch";
  };
  teams = final.webapp.override {
    name = "teams";
    url = "https://teams.microsoft.com";
  };
  telegram-web = final.webapp.override {
    name = "telegram";
    url = "https://web.telegram.org";
  };
  whatsapp = final.webapp.override {
    name = "whatsapp";
    url = "https://web.whatsapp.com";
  };

  vimPlugins = prev.vimPlugins.extend (_: _: localpkgs.vimPlugins);
}
