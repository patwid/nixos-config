{ pkgs, ... }:
let
  user = import ./user.nix;
  colors = import ./colors.nix;
in {
  home-manager.users.${user} = {
    programs.qutebrowser = {
      enable = true;
      quickmarks = {
        hm = "https://nix-community.github.io/home-manager/options.html";
        no = "https://nixos.org/manual/nixos/stable/options.html";
        yt = "https://youtube.com";
      };
      searchEngines = {
        DEFAULT = "https://duckduckgo.com/?q={}&kae=b&kz=-1&kau=-1&kao=-1&kap=-1&kaq=-1&kax=-1&kak=-1&k1=-1";
        aw = "https://wiki.archlinux.org/?search={}";
        g = "https://www.google.com/search?q={}";
        no = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
        np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
        yt = "https://youtube.com/results?search_query={}";
      };
      settings = {
        url.start_pages = [ "about:blank" ];
        url.default_page = "about:blank";
        tabs.mousewheel_switching = false;
        tabs.favicons.show = "pinned";
        tabs.indicator.width = 0;
        statusbar.widgets = [ "url" "progress" ];
        scrolling.smooth = true;
        # content.cookies.store = false;
        colors = {
          completion = {
            category.bg = "${colors.black}";
            category.border.bottom = "${colors.black}";
            category.border.top = "${colors.black}";
            category.fg = "${colors.lightGrey}";
            even.bg = "${colors.black}";
            fg = "${colors.lightGrey}";
            item.selected.bg = "${colors.blue}";
            item.selected.border.bottom = "${colors.blue}";
            item.selected.border.top = "${colors.blue}";
            item.selected.fg = "${colors.black}";
            item.selected.match.fg = "${colors.black}";
            match.fg = "${colors.lightGrey}";
            odd.bg = "${colors.black}";
            scrollbar.bg = "${colors.black}";
            scrollbar.fg = "${colors.lightGrey}";
          };
          downloads = {
            bar.bg = "${colors.black}";
            error.bg = "${colors.red}";
            error.fg = "${colors.black}";
            start.bg = "${colors.yellow}";
            start.fg = "${colors.black}";
            stop.bg = "${colors.green}";
            stop.fg = "${colors.black}";
          };
          hints.bg = "${colors.yellow}";
          hints.fg = "${colors.black}";
          hints.match.fg = "${colors.darkGrey}";
          # keyhint.bg = 'rgba(0, 0, 0, 80%)'
          keyhint.fg = "${colors.white}";
          keyhint.suffix.fg = "${colors.white}";
          messages = {
            error.bg = "${colors.red}";
            error.border = "${colors.red}";
            error.fg = "${colors.black}";
            info.bg = "${colors.black}";
            info.border = "${colors.black}";
            info.fg = "${colors.white}";
            warning.bg = "${colors.yellow}";
            warning.border = "${colors.yellow}";
            warning.fg = "${colors.black}";
          };
          prompts = {
            bg = "${colors.black}";
            border = "${colors.black}";
            fg = "${colors.white}";
            selected.bg = "${colors.blue}";
            selected.fg = "${colors.black}";
          };
          statusbar = {
            caret.bg = "${colors.black}";
            caret.fg = "${colors.white}";
            caret.selection.bg = "${colors.black}";
            caret.selection.fg = "${colors.white}";
            command.bg = "${colors.black}";
            command.fg = "${colors.white}";
            command.private.bg = "${colors.darkerGrey}";
            command.private.fg = "${colors.white}";
            insert.bg = "${colors.black}";
            insert.fg = "${colors.white}";
            normal.bg = "${colors.black}";
            normal.fg = "${colors.white}";
            passthrough.bg = "${colors.black}";
            passthrough.fg = "${colors.white}";
            private.bg = "${colors.darkerGrey}";
            private.fg = "${colors.white}";
            progress.bg = "${colors.white}";
            url.error.fg = "${colors.white}";
            url.fg = "${colors.white}";
            url.hover.fg = "${colors.white}";
            url.success.http.fg = "${colors.white}";
            url.success.https.fg = "${colors.white}";
            url.warn.fg = "${colors.white}";
          };
          tabs = {
            bar.bg = "${colors.black}";
            even.bg = "${colors.darkestGrey}";
            even.fg = "${colors.lightGrey}";
            indicator.error = "${colors.red}";
            indicator.start = "${colors.black}";
            indicator.stop = "${colors.green}";
            odd.bg = "${colors.darkestGrey}";
            odd.fg = "${colors.lightGrey}";
            pinned.even.bg = "${colors.darkestGrey}";
            pinned.even.fg = "${colors.lightGrey}";
            pinned.odd.bg = "${colors.darkestGrey}";
            pinned.odd.fg = "${colors.lightGrey}";
            pinned.selected.even.bg = "${colors.blue}";
            pinned.selected.even.fg = "${colors.black}";
            pinned.selected.odd.bg = "${colors.blue}";
            pinned.selected.odd.fg = "${colors.black}";
            selected.even.bg = "${colors.blue}";
            selected.even.fg = "${colors.black}";
            selected.odd.bg = "${colors.blue}";
            selected.odd.fg = "${colors.black}";
          };
          webpage.bg = "${colors.white}";
        };
      };
      keyBindings = {
        normal = {
          ",m" = "spawn --detach ${pkgs.mpv}/bin/mpv {url}";
          ",M" = "hint links spawn --detach ${pkgs.mpv}/bin/mpv {hint-url}";
          ";M" = "hint --rapid links spawn --detach ${pkgs.mpv}/bin/mpv {hint-url}";
          ",u" = "spawn ${pkgs.mpv}/bin/umpv {url}";
          ",U" = "hint links spawn ${pkgs.mpv}/bin/umpv {hint-url}";
          ";U" = "hint --rapid links spawn ${pkgs.mpv}/bin/umpv {hint-url}";
        };
      };
    };
  };
}
