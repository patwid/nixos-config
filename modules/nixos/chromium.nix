{ config, ... }:
let inherit (config) colors; in
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
    defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      # "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
    ];
    # https://chromeenterprise.google/policies/
    extraOpts = {
      "AutoFillEnabled" = false;
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
      "BookmarkBarEnabled" = false;
      "BrowserSignin" = 0; # Disable browser sign-in
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
      "SpellCheckServiceEnabled" = false;
      "SpellcheckEnabled" = false;
      "SyncDisabled" = true;
      "TranslateEnabled" = false;

      # You and Google > Sync and Google services > Improve search suggestions
      # Privacy and security > Send a "Do Not Track" request with your browser traffic
      # Appearance > Use system title bar and borders
    };
  };
}
