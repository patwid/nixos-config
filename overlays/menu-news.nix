{ ... }:
final: prev: {
  menu-news = prev.menu-feed.override { name = "news"; opener = final.xdg-open; };
}
