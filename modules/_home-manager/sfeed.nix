{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.sfeed;
  optString = s: lib.optionalString (s != null) ''"${s}"'';
  feedToString =
    {
      name,
      url,
      basesiteurl,
      encoding,
    }:
    ''feed "${name}" "${url}"${optString basesiteurl}${optString encoding}'';
in
{
  options = {
    sfeed = {
      feeds = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.listOf (
            lib.types.submodule {
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
            }
          )
        );
      };
    };
  };

  config = {
    sfeed.feeds = {
      news = [
        {
          name = "hackernews";
          url = "https://news.ycombinator.com/rss";
        }
        {
          name = "lobsters";
          url = "https://lobste.rs/rss";
        }
        {
          name = "drewdevault";
          url = "https://drewdevault.com/blog/index.xml";
        }
        {
          name = "emersion";
          url = "https://emersion.fr/blog/atom.xml";
        }
      ];
      # Get youtube Atom feed: curl -s -L 'https://www.youtube.com/user/gocoding/videos' | sfeed_web | cut -f 1
      videos = [
        {
          name = "Backpacker Ben";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7McxlM5qJVjqLBRYcHyylg";
        }
        {
          name = "bald and bankrupt";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCxDZs_ltFFvn0FDHT6kmoXA";
        }
        {
          name = "gamozolabs";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC17ewSS9f2EnkCyMztCdoKA";
        }
        {
          name = "gotbletu";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCkf4VIqu3Acnfzuk3kRIFwA";
        }
        {
          name = "Harald Baldr";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCKr68ZJ4vv6VloNdnS2hjhA";
        }
        {
          name = "Harry Jaggard";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC8fwExOkHg0_fX_XJcR31NA";
        }
        {
          name = "Indigo Traveller";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCXulruMI7BHj3kGyosNa0jA";
        }
        {
          name = "Kino Yves";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCUTUeNtu9eTtVSaxOumm7tw";
        }
        {
          name = "Kurt Caz";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC29vLPlafHcsqZu3L-Rk_pA";
        }
        {
          name = "LiveOverflow";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UClcE-kVhqyiHCcjYwcpfj9w";
        }
        {
          name = "Mental Outlaw";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7YOGHUfC1Tb6E4pudI9STA";
        }
        {
          name = "Timmy Karter";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC29Cfp-srhuP40b9YD-Q4oA";
        }
        {
          name = "Tsoding Daily";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCrqM0Ym_NbK1fqeQG2VIohg";
        }
        {
          name = "Sabbatical";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCib80j_q5o_C5XsCA9YsAFg";
        }
        {
          name = "William Taudien";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCyZx4_APzg857xynqb4hrjg";
        }
        {
          name = "World Nomac";
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCpL_tis0ertYh2DSOiCm51g";
        }
      ];
      podcasts = [
        {
          name = "Echo der Zeit";
          url = "https://www.srf.ch/feed/podcast/sd/28549e81-c453-4671-92ad-cb28796d06a8.xml";
        }
        {
          name = "Wirtschaftswoche";
          url = "https://www.srf.ch/feed/podcast/sd/7f5b4cad-b410-4ab9-a437-b3ebfe8867e4.xml";
        }
        {
          name = "NZZ Akzent";
          url = "https://akzent.podigee.io/feed/mp3";
        }
        {
          name = "Apropos";
          url = "https://partner-feeds.publishing.tamedia.ch/rss/tagesanzeiger/podcast/apropos-taeglicher-podcast";
        }
        {
          name = "Late Night Linux";
          url = "https://latenightlinux.com/feed/mp3";
        }
        {
          name = "Linux Downtime";
          url = "https://latenightlinux.com/feed/extra";
        }
        {
          name = "Linux After Dark";
          url = "https://linuxafterdark.net/feed/podcast";
        }
        {
          name = "Linux Matters";
          url = "https://linuxmatters.sh/episode/index.xml";
        }
        {
          name = "2.5 Admins";
          url = "https://2.5admins.com/feed/podcast";
        }
        {
          name = "Linux Unplugged";
          url = "https://feeds.fireside.fm/linuxunplugged/rss";
        }
        {
          name = "Coder Radio";
          url = "https://feeds.fireside.fm/coder/rss";
        }
        {
          name = "Selfhosted";
          url = "https://feeds.fireside.fm/selfhosted/rss";
        }
      ];
    };

    home.packages = with pkgs; [
      sfeed
      menu-news
      menu-videos
      menu-podcasts
    ];

    xdg.dataFile = lib.mapAttrs' (
      type: feed:
      lib.nameValuePair "sfeed/${type}/sfeedrc" {
        text = ''
          sfeedpath="$HOME/.local/share/sfeed/${type}/feeds"

          feeds() {
          ''\t# feed <name> <feedurl> [basesiteurl] [encoding]
          ''\t${lib.concatStringsSep "\n\t" (map feedToString feed)}
          }
        '';
      }
    ) cfg.feeds;
  };
}
