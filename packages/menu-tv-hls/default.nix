{ menu-tv }:
menu-tv.override {
  name = "tv-hls";
  channels = builtins.path { name = "channels-tv-hls"; path = ./channels.txt; };
}
