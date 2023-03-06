{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  # Required for screen sharing to work
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=WebRTCPipeWireCapturer";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Enable native wayland support in chromium
  };

  programs.chromium = {
    enable = true;
    homepageLocation = "about:blank";
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}&kae=b&kz=-1&kau=-1&kao=-1&kap=-1&kaq=-1&kax=-1&kak=-1&k1=-1";
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
    extraOpts = {
      "AutofillAddressEnabled" = false;
      "BookmarkBarEnabled" = false;
      "BrowserSignin" = false;
      "ClearBrowsingDataOnExitList" = [
        "browsing_history"
        "download_history"
        "cookies_and_other_site_data"
        "cached_images_and_files"
        "password_signin"
        "autofill"
        "site_settings"
        "hosted_app_data"
      ];
      "NewTabPageLocation" = "about:blank";
      "PasswordManagerEnabled" = false;
      "PaymentMethodQueryEnabled" = false;
      "PromptForDownloadLocation" = true;
      "ShowHomeButton" = false;
      "SyncDisabled" = true;
    };
  };

  home-manager.users.${user.name} = {
    programs.chromium.enable = true;
  };
}
