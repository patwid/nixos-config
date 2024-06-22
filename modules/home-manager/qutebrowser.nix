{ osConfig, pkgs, ... }:
let
  inherit (osConfig) colors;
in
{
  home.sessionVariables = {
    BROWSER = "qutebrowser";

    # https://github.com/qutebrowser/qutebrowser/discussions/7938
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };

  programs.qutebrowser = {
    enable = true;
    quickmarks = {
      b = "https://jira.ergon.ch/secure/RapidBoard.jspa?rapidView=99&quickFilter=2544";
      ab = "https://jira.axonlab.com/secure/RapidBoard.jspa?rapidView=73&view=planning.nodetail&quickFilter=527&issueLimit=100";
      gb = "https://jira.axonlab.com/secure/RapidBoard.jspa?rapidView=88&view=planning.nodetail&issueLimit=100";
      g = "https://grafana.axenita.dev/";
      i3 = "https://i3wm.org/docs/userguide.html";
      ls = "https://logsearch.axenita.dev/";
      nt = "https://nixpk.gs/pr-tracker.html";
      nc = "https://git.sr.ht/~patwid/nixos-config";
      s = "http://stash.ergon.ch/";
      st = "http://localhost:8384/";
      stn = "http://syncthing.local:8384/";
      t = "https://tower.axenita.dev/";
      td = "https://tower-dev.axenita.dev/";
      tm = "http://transmission.local:9091/transmission/web/";
      yt = "https://youtube.com";
      mt = "https://webmail.flashcable.ch/";
      c = "https://confluence.ergon.ch/";
      ac = "https://confluence.axonlab.com/";
      dd = "https://app.datadoghq.eu/";
      "1p" = "https://ergon.1password.eu/";
    };
    searchEngines = {
      # URL parameters documentation: https://duckduckgo.com/duckduckgo-help-pages/settings/params/
      DEFAULT = "https://duckduckgo.com/?kf=-1&k1=-1&ka=h&kt=h&kx=g&q={}";
      a = "https://jira.ergon.ch/browse/AXONLAB-{}";
      aw = "https://intern.achilles-online.ch/jira/browse/AW-{}";
      g = "https://www.google.com/search?q={}";
      no = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      nt = "https://nixpk.gs/pr-tracker.html?pr={}";
      p = "https://perplexity.ai/search?q={}";
      s = "https://git.sr.ht/~{}";
      sp = "https://git.sr.ht/~patwid/{}";
      wa = "https://wiki.archlinux.org/?search={}";
      yt = "https://youtube.com/results?search_query={}";
      ytm = "https://music.youtube.com/search?q={}";
    };
    settings = {
      fonts.default_family = [ "sans-serif" ];
      url.start_pages = [ "about:blank" ];
      url.default_page = "about:blank";
      tabs = {
        mousewheel_switching = false;
        favicons.show = "pinned";
        indicator.width = 0;
      };
      statusbar = {
        widgets = [ "url" "progress" ];
      };
      scrolling.smooth = true;
      content.cookies.store = false;
      completion.open_categories = [ "quickmarks" "history" "filesystem" ];
      colors = {
        completion = {
          category.bg = colors.background;
          category.border.bottom = colors.background;
          category.border.top = colors.background;
          category.fg = colors.foreground;
          even.bg = colors.background;
          fg = colors.foreground;
          item.selected.bg = colors.backgroundActive;
          item.selected.border.bottom = colors.backgroundActive;
          item.selected.border.top = colors.backgroundActive;
          item.selected.fg = colors.foreground;
          item.selected.match.fg = colors.foreground;
          match.fg = colors.foreground;
          odd.bg = colors.background;
          scrollbar.bg = colors.background;
          scrollbar.fg = colors.foreground;
        };
        downloads = {
          bar.bg = colors.backgroundInactive;
          error.bg = colors.red;
          error.fg = colors.lighterGrey;
          start.bg = colors.yellow;
          start.fg = colors.darkerGrey;
          stop.bg = colors.green;
          stop.fg = colors.backgroundInactive;
        };
        hints.bg = colors.yellow;
        hints.fg = colors.darkerGrey;
        hints.match.fg = colors.foregroundInactive;
        keyhint.bg = colors.background;
        keyhint.fg = colors.foreground;
        keyhint.suffix.fg = colors.foreground;
        messages = {
          error.bg = colors.red;
          error.border = colors.red;
          error.fg = colors.lighterGrey;
          info.bg = colors.backgroundInactive;
          info.border = colors.backgroundInactive;
          info.fg = colors.foreground;
          warning.bg = colors.yellow;
          warning.border = colors.yellow;
          warning.fg = colors.darkerGrey;
        };
        prompts = {
          bg = colors.background;
          border = colors.background;
          fg = colors.foreground;
          selected.bg = colors.blue;
          selected.fg = colors.background;
        };
        statusbar = {
          caret.bg = colors.backgroundInactive;
          caret.fg = colors.foreground;
          caret.selection.bg = colors.backgroundActive;
          caret.selection.fg = colors.foreground;
          command.bg = colors.backgroundInactive;
          command.fg = colors.foreground;
          command.private.bg = colors.backgroundActive;
          command.private.fg = colors.foreground;
          insert.bg = colors.backgroundInactive;
          insert.fg = colors.foreground;
          normal.bg = colors.backgroundInactive;
          normal.fg = colors.foreground;
          passthrough.bg = colors.backgroundInactive;
          passthrough.fg = colors.foreground;
          private.bg = colors.backgroundInactive;
          private.fg = colors.foreground;
          progress.bg = colors.foreground;
          url.error.fg = colors.foreground;
          url.fg = colors.foreground;
          url.hover.fg = colors.foreground;
          url.success.http.fg = colors.foreground;
          url.success.https.fg = colors.foreground;
          url.warn.fg = colors.foreground;
        };
        tabs = {
          bar.bg = colors.backgroundInactive;
          even.bg = colors.backgroundInactive;
          even.fg = colors.foregroundInactive;
          indicator.error = colors.red;
          indicator.start = colors.backgroundInactive;
          indicator.stop = colors.green;
          odd.bg = colors.backgroundInactive;
          odd.fg = colors.foregroundInactive;
          pinned.even.bg = colors.backgroundInactive;
          pinned.even.fg = colors.foregroundInactive;
          pinned.odd.bg = colors.backgroundInactive;
          pinned.odd.fg = colors.foregroundInactive;
          pinned.selected.even.bg = colors.backgroundActive;
          pinned.selected.even.fg = colors.foreground;
          pinned.selected.odd.bg = colors.backgroundActive;
          pinned.selected.odd.fg = colors.foreground;
          selected.even.bg = colors.backgroundActive;
          selected.even.fg = colors.foreground;
          selected.odd.bg = colors.backgroundActive;
          selected.odd.fg = colors.foreground;
        };
        webpage.bg = colors.white;
        webpage.preferred_color_scheme = colors.variant;
      };
    };
    keyBindings =
      let
        mpv = "${pkgs.mpv}/bin/mpv";
        umpv = "${pkgs.mpv}/bin/umpv";
      in
      {
        normal = {
          ",m" = "spawn --detach ${mpv} {url}";
          ",M" = "hint links spawn --detach ${mpv} {hint-url}";
          ";M" = "hint --rapid links spawn --detach ${mpv} {hint-url}";
          ",u" = "spawn ${umpv} {url}";
          ",U" = "hint links spawn ${umpv} {hint-url}";
          ";U" = "hint --rapid links spawn ${umpv} {hint-url}";

          # Saving quickmarks is not supported on NixOS due to the nix store
          # being read-only
          "m" = null;
        };
      };
  };
}
