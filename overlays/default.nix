{ nixpkgs-stable, config, ... }@inputs:
final: prev:
let
  inherit (config) ideaExtraVmopts;
  localpkgs = import ../pkgs (inputs // { pkgs = prev; });
in
localpkgs //
{
  stable = import nixpkgs-stable { inherit (prev) config system; };

  menu-news = final.menu-feed.override { name = "news"; opener = final.xdg-open; };
  menu-podcasts = final.menu-feed.override { name = "podcasts"; opener = prev.mpv; };
  menu-videos = final.menu-feed.override { name = "videos"; opener = prev.mpv; };

  menu-movies = final.menu-mpv.override { name = "movies"; path = "~/videos/movies"; };
  menu-music = final.menu-mpv.override { name = "music"; path = "~/music"; };
  menu-shows = final.menu-mpv.override { name = "shows"; path = "~/videos/tv_shows"; };

  mattermost = final.webapp.override { name = "mattermost"; url = "https://mattermost.ergon.ch"; };
  outlook = final.webapp.override { name = "outlook"; url = "https://outlook.office.com/mail"; };
  smartaz = final.webapp.override { name = "smartaz"; url = "https://smartaz.ergon.ch"; };
  teams = final.webapp.override { name = "teams"; url = "https://teams.microsoft.com"; };
  whatsapp = final.webapp.override { name = "whatsapp"; url = "https://web.whatsapp.com"; };

  notify-low-battery = final.notify.override {
    name = "notify-low-battery";
    summary = "Warning";
    body = "Low Battery";
  };

  pass = prev.pass.override { dmenuSupport = false; };

  jetbrains =
    let
      inherit (prev) jetbrains;
      idea-ultimate = jetbrains.idea-ultimate.override {
        vmopts = ''
          -Dawt.toolkit.name=WLToolkit
        '' + ideaExtraVmopts;
      };
    in
    jetbrains // { idea-ultimate = jetbrains.plugins.addPlugins idea-ultimate [ "ideavim" ]; };
}
