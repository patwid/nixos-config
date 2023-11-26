{ config, lib, pkgs, ... }:
let
  inherit (config) user;

  cfg = config.sfeed;
  optString = s: lib.optionalString (s != null) '' "${s}"'';
  feedToString = { name, url, basesiteurl, encoding }:
    ''feed "${name}" "${url}"${optString basesiteurl}${optString encoding}'';

  feedType = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
      };
      url = lib.mkOption {
        type = lib.types.str;
      };
      basesiteurl = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      encoding = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
in
{
  options = {
    sfeed = {
      feeds = {
        news = lib.mkOption {
          type = lib.types.listOf feedType;
        };
        videos = lib.mkOption {
          type = lib.types.listOf feedType;
        };
        podcasts = lib.mkOption {
          type = lib.types.listOf feedType;
        };
      };
    };
  };

  config = {
    sfeed.feeds = {
      news = [
        { name = "hackernews"; url = "https://news.ycombinator.com/rss"; }
        { name = "lobsters"; url = "https://lobste.rs/rss"; }
        { name = "drewdevault"; url = "https://drewdevault.com/blog/index.xml"; }
      ];
      # Get youtube Atom feed: curl -s -L 'https://www.youtube.com/user/gocoding/videos' | sfeed_web | cut -f 1
      videos = [
        { name = "ben"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7McxlM5qJVjqLBRYcHyylg"; }
      ];
      podcasts = [
        # TODO
      ];
    };

    home-manager.users.${user.name} = {
      home.packages = with pkgs; [ sfeed menu-news menu-videos menu-podcasts ];

      xdg.configFile."sfeed/news/sfeedrc".text = ''
        sfeedpath="$HOME/.config/sfeed/news/feeds"

        feeds() {
        ''\t# feed <name> <feedurl> [basesiteurl] [encoding]
        ''\t${lib.concatStringsSep "\n\t" (map feedToString cfg.feeds.news)}
        }
      '';

      xdg.configFile."sfeed/videos/sfeedrc".text = ''
        sfeedpath="$HOME/.config/sfeed/videos/feeds"

        feeds() {
        ''\t# feed <name> <feedurl> [basesiteurl] [encoding]
        ''\t${lib.concatStringsSep "\n\t" (map feedToString cfg.feeds.videos)}
        }
      '';

      xdg.configFile."sfeed/podcasts/sfeedrc".text = ''
        sfeedpath="$HOME/.config/sfeed/podcasts/feeds"

        feeds() {
        ''\t# feed <name> <feedurl> [basesiteurl] [encoding]
        ''\t${lib.concatStringsSep "\n\t" (map feedToString cfg.feeds.podcasts)}
        }
      '';
    };
  };
}
