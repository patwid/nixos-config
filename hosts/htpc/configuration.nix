{ args, pkgs, nixos-hardware, nixos-apple-silicon, ... }:
let
  inherit (args) user;
in
{
  imports = [
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  home = true;
  apple-silicon = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  home-manager.users.${user} = {
    wayland.windowManager.sway.config = {
      output.HDMI-A-1.scale = "2";
    };

    programs.qutebrowser.package = pkgs.qutebrowser-qt6;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}
