{ menu-feed, xdg-open }:
menu-feed.override {
  name = "news";
  opener = xdg-open;
}
