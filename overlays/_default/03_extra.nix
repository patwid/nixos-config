_: final: prev: {
  teleport_16 = prev.teleport_16.override {
    withRdpClient = false;
  };

  menu-news = prev.menu-feed.override {
    name = "news";
    opener = prev.xdg-open;
  };
  menu-podcasts = prev.menu-feed.override {
    name = "podcasts";
    opener = prev.mpv;
  };
  menu-videos = prev.menu-feed.override {
    name = "videos";
    opener = prev.mpv;
  };

  menu-movies = prev.menu-mpv.override {
    name = "movies";
    path = "~/videos/movies";
  };
  menu-music = prev.menu-mpv.override {
    name = "music";
    path = "~/music";
  };
  menu-shows = prev.menu-mpv.override {
    name = "shows";
    path = "~/videos/tv_shows";
  };

  _1password = prev.webapp.override {
    name = "1password";
    url = "https://ergon.1password.eu";
  };
  mattermost = prev.webapp.override {
    name = "mattermost";
    url = "https://mattermost.ergon.ch";
  };
  medbase = prev.webapp.override {
    name = "medbase";
    url = "https://post.sa-portal.ch";
  };
  outlook = prev.webapp.override {
    name = "outlook";
    url = "https://outlook.office.com/mail";
  };
  rds = prev.webapp.override {
    name = "rds";
    url = "https://rds.ergon.ch";
  };
  sanacare = prev.webapp.override {
    name = "sanacare";
    url = "https://sanacare.cloud.com";
  };
  smartaz = prev.webapp.override {
    name = "smartaz";
    url = "https://smartaz.ergon.ch";
  };
  teams = prev.webapp.override {
    name = "teams";
    url = "https://teams.microsoft.com";
  };
  telegram-web = prev.webapp.override {
    name = "telegram";
    url = "https://web.telegram.org";
  };
  whatsapp = prev.webapp.override {
    name = "whatsapp";
    url = "https://web.whatsapp.com";
  };
}
