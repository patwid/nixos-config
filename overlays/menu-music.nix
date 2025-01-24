{ ... }:
final: prev: {
  menu-music = prev.menu-mpv.override { name = "music"; path = "~/music"; };
}
