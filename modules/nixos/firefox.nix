{
  pkgs,
  ...
}:
{
  programs.firefox = {
    enable = true;

    # https://mozilla.github.io/policy-templates/
    policies = {
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxAccounts = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OffertosaveloginsDefault = false;
      PasswordManagerEnabled = false;

      # Install extensions via policy
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      # Set default search engine
      SearchEngines = {
        Default = "DuckDuckGo";
        Remove = [
          "Amazon.de"
          "Bing"
          "eBay"
          "Google"
          "Wikipedia"
        ];
      };
    };

    # about:config — set as default (user can override) or locked
    preferences = {
      "browser.download.useDownloadDir" = false;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.showSearch" = false;
      "browser.newtabpage.enabled" = false;
      "browser.search.suggest.enabled" = false;
      "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
      "browser.tabs.firefox-view" = false;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.translations.automaticallyPopup" = false;
      "browser.urlbar.suggest.addons" = false;
      "browser.urlbar.suggest.bestmatch" = false;
      "browser.urlbar.suggest.bookmark" = false;
      "browser.urlbar.suggest.calculator" = false;
      "browser.urlbar.suggest.clipboard" = false;
      "browser.urlbar.suggest.engines" = false;
      "browser.urlbar.suggest.history" = false;
      "browser.urlbar.suggest.mdn" = false;
      "browser.urlbar.suggest.pocket" = false;
      "browser.urlbar.suggest.remotetabe" = false;
      "browser.urlbar.suggest.search" = false;
      "browser.urlbar.suggest.topsites" = false;
      "browser.urlbar.suggest.trending" = false;
      "browser.urlbar.suggest.weather" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "extensions.pocket.enabled" = false;
      "layout.spellcheckDefault" = 0;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.siteSettings" = true;
      "privacy.donottrackheader.enabled" = true;
      "signon.autofillForms" = false;
      "signon.management.page.breach-alerts.enabled" = false;
    };

    preferencesStatus = "default";
  };
}
