{ ... }:
final: prev: {
  menu-podcasts = prev.menu-feed.override { name = "podcasts"; opener = "mpv"; };
}
