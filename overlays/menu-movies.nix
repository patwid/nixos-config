{ ... }:
final: prev: {
  menu-movies = prev.menu-mpv.override { name = "movies"; path = "~/videos/movies"; };
}
