{ config, lib, pkgs, ... }:
let
  inherit (config) user;

  cfg = config.sfeed;
  optString = s: lib.optionalString (s != null) '' "${s}"'';
  feedToString = { name, url, basesiteurl, encoding }:
    ''feed "${name}" "${url}"${optString basesiteurl}${optString encoding}'';
in
{
  options = {
    sfeed = {
      feeds = lib.mkOption {
        type = lib.types.attrsOf (lib.types.listOf (lib.types.submodule {
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
        }));
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
        { name = "Backpacker Ben"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7McxlM5qJVjqLBRYcHyylg"; }
      ];
      podcasts = [
        # TODO
      ];
    };

    home-manager.users.${user.name} = {
      home.packages = with pkgs; [ sfeed menu-news menu-videos menu-podcasts ];

      xdg.configFile = lib.mapAttrs'
        (type: feed: lib.nameValuePair
          "sfeed/${type}/sfeedrc"
          {
            text = ''
              sfeedpath="$HOME/.config/sfeed/${type}/feeds"

              feeds() {
              ''\t# feed <name> <feedurl> [basesiteurl] [encoding]
              ''\t${lib.concatStringsSep "\n\t" (map feedToString feed)}
              }
            '';
          })
        cfg.feeds;
    };
  };
}
