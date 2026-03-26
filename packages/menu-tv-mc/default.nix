{ menu-tv }:
menu-tv.override {
  name = "tv-mc";
  channels = builtins.path { name = "channels-tv-mc"; path = ./channels.txt; };
}
