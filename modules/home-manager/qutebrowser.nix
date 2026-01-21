{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (osConfig) colors;
in
{
  home.sessionVariables = {
    BROWSER = "qutebrowser";
  };

  programs.qutebrowser = {
    enable = true;
    quickmarks = {
      "1p" = "https://ergon.1password.eu/";
      ac = "https://axonlab.atlassian.net/wiki/home";
      aj = "https://axonlab.atlassian.net/";
      b = "https://jira.ergon.ch/secure/RapidBoard.jspa?rapidView=767";
      ba = "https://jira.ergon.ch/secure/RapidBoard.jspa?rapidView=99&quickFilter=2544";
      bb = "http://stash.ergon.ch/";
      bl = "https://axonlab.atlassian.net/jira/software/c/projects/AW/boards/13/backlog?label=omega";
      c = "https://confluence.ergon.ch/";
      g = "https://grafana.axlab.ch/";
      gd = "https://grafana.axenita.dev/";
      lb = "https://dev-latest-beta.axlab.ch/api/axonlab/login/axenita";
      lbb = "https://dev-latest-beta-axon-baden.axlab.ch/api/axonlab/login/axenita";
      lbt = "https://dev-latest-beta-axon-thun.axlab.ch/api/axonlab/login/axenita";
      lbz = "https://dev-latest-beta-axon-zuerich.axlab.ch/api/axonlab/login/axenita";
      lm = "https://dev-latest-master.axlab.ch/api/axonlab/login/axenita";
      lmb = "https://dev-latest-master-axon-baden.axlab.ch/api/axonlab/login/axenita";
      lmt = "https://dev-latest-master-axon-thun.axlab.ch/api/axonlab/login/axenita";
      lmz = "https://dev-latest-master-axon-zuerich.axlab.ch/api/axonlab/login/axenita";
      log = "https://logsearch.axenita.dev/";
      ls = "https://dev-latest-stable.axlab.ch/api/axonlab/login/axenita";
      lsb = "https://dev-latest-stable-axon-baden.axlab.ch/api/axonlab/login/axenita";
      lst = "https://dev-latest-stable-axon-thun.axlab.ch/api/axonlab/login/axenita";
      lsz = "https://dev-latest-stable-axon-zuerich.axlab.ch/api/axonlab/login/axenita";
      mp = "https://post.sa-portal.ch/";
      mt = "https://webmail.flashcable.ch/";
      nc = "https://git.sr.ht/~patwid/nixos-config";
      nt = "https://nixpk.gs/pr-tracker.html";
      ph = "https://plat-homepage.axlab.ch/";
      sc = "https://sanacare.cloud.com";
      st = "http://localhost:8384/";
      stn = "http://syncthing.local:8384/";
      t = "http://transmission.local:9091/transmission/web/";
      td = "https://tower.axlab.ch/";
      tl = "https://tower-latestmaster.axlab.ch/";
      tp = "https://tower.axenita.ch/";
      tt = "https://tower-test.axlab.ch/instances";
      yt = "https://youtube.com";
    };
    searchEngines = {
      # URL parameters documentation: https://duckduckgo.com/duckduckgo-help-pages/settings/params/
      DEFAULT = "https://duckduckgo.com/?q={}";
      a = "https://jira.ergon.ch/browse/AXONLAB-{}";
      aw = "https://axonlab.atlassian.net/browse/AW-{}";
      ax = "https://dev-latest-{}.axlab.ch/frame.html";
      g = "https://www.google.com/search?q={}";
      no = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      nt = "https://nixpk.gs/pr-tracker.html?pr={}";
      p = "https://axonlab.atlassian.net/browse/PROB-{}";
      pt = "https://axonlab.atlassian.net/browse/PLAT-{}";
      px = "https://perplexity.ai/search?q={}";
      s = "https://git.sr.ht/~{}";
      sp = "https://git.sr.ht/~patwid/{}";
      t = "https://trouble{}.axlab.ch/api/login/axenita";
      ta = "https://trouble{}.axlab.ch/api/login/admin";
      wa = "https://wiki.archlinux.org/?search={}";
      yt = "https://youtube.com/results?search_query={}";
      ytm = "https://music.youtube.com/search?q={}";
    };
    settings = {
      fonts.default_family = [ "monospace" ];
      url.start_pages = [ "about:blank" ];
      url.default_page = "about:blank";
      tabs = {
        mousewheel_switching = false;
        favicons.show = "pinned";
        indicator.width = 0;
      };
      statusbar = {
        widgets = [
          "url"
          "progress"
        ];
      };
      scrolling.smooth = true;
      content.cookies.store = false;
      content.private_browsing = true;
      completion.open_categories = [
        "quickmarks"
        "history"
        "filesystem"
      ];
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
          start.bg = colors.backgroundActive;
          start.fg = colors.foreground;
          stop.bg = colors.backgroundActive;
          stop.fg = colors.foreground;
        };
        hints.bg = colors.yellow;
        hints.fg = colors.darkerGrey;
        hints.match.fg = colors.yellow;
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
      };
    };
    keyBindings =
      let
        mpv = lib.getExe pkgs.mpv;
        umpv = lib.getExe' pkgs.mpv "umpv";
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
