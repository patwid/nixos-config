{ ... }:
final: prev: {
  menu-shows = prev.menu-mpv.override { name = "shows"; path = "~/videos/tv_shows"; };
}
