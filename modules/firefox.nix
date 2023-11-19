{ config, pkgs, nur, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user.name} = {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        # https://mozilla.github.io/policy-templates/
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
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
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
        # about:config
        settings = {
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
      };
    };
  };
}
