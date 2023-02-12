{ pkgs, ... }:
let
  user = import ./user.nix;
in {
  # Required for screen sharing to work
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=WebRTCPipeWireCapturer";

  home-manager.users.${user} = {
      home.packages = [ pkgs.chromium ];
      home.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Enable native wayland support in chromium
      };

      # programs.chromium.enable = true;
  };
}
