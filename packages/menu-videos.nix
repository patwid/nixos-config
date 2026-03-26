{
  menu-feed,
  mpv,
  sfeedrc ? null,
}:
menu-feed.override {
  name = "videos";
  opener = mpv;
  inherit sfeedrc;
}
