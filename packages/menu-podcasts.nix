{
  menu-feed,
  mpv,
  sfeedrc ? null,
}:
menu-feed.override {
  name = "podcasts";
  opener = mpv;
  inherit sfeedrc;
}
