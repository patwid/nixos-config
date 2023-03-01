{ config, pkgs, args, ... }:
{
  home-manager.users.${args.user} = {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFirefoxAccounts = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OffertosaveloginsDefault = false;
          PasswordManagerEnabled = false;
        };
      };
      profiles.default = {
        extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];
        search.default = "DuckDuckGo";
        search.force = true;
        search.engines = {
          "Amazon.de".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
        settings = {
          "browser.download.useDownloadDir" = "never";
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSearch" = false;
          "browser.newtabpage.enabled" = false;
          "browser.search.suggest.enabled" = false;
          "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
          "browser.tabs.firefox-view" = false;
          "browser.toolbars.bookmarks.visibility" = false;
          "browser.urlbar.suggest.engines" = false;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.donottrackheader.enabled" = true;
        };
      };
    };
  };
}
