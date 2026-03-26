{ menu-feed, xdg-open, sfeedrc ? null }:
menu-feed.override {
  name = "news";
  opener = xdg-open;
  inherit sfeedrc;
}
