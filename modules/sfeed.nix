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
        type = lib.types.listOf (lib.types.submodule {
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
        });
      };
    };
  };

  config = {
    sfeed.feeds = [
      { name = "hackernews"; url = "https://news.ycombinator.com/rss"; }
      { name = "lobsters"; url = "https://lobste.rs/rss"; }
      { name = "drewdevault"; url = "https://drewdevault.com/blog/index.xml"; }
    ];

    home-manager.users.${user.name} = {
      home.packages = with pkgs; [ sfeed menu-news ];

      xdg.configFile."sfeed/sfeedrc".text = ''
        sfeedpath="$HOME/.config/sfeed/feeds"

        feeds() {
        ''\t# get youtube Atom feed: curl -s -L 'https://www.youtube.com/user/gocoding/videos' | sfeed_web | cut -f 1
        ''\t# feed <name> <feedurl> [basesiteurl] [encoding]
        ''\t${lib.concatStringsSep "\n\t" (map feedToString cfg.feeds)}
        }
      '';
    };
  };
}
