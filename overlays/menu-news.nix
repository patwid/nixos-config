{ ... }:
final: prev: {
  menu-news = prev.menu-feed.override { name = "news"; opener = "xdg-open"; };
}
