{ ... }:
final: prev: {
  menu-videos = prev.menu-feed.override { name = "videos"; opener = prev.mpv; };
}
