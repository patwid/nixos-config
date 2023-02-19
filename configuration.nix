{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./home.nix

    ./doas.nix
    ./docker.nix
    ./fonts.nix
    ./home-shares.nix
    ./localization.nix
    ./networkmanager.nix
    ./openssh.nix
    ./openvpn.nix
    ./systemdboot.nix
    ./users.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc.automatic = true;
  nix.gc.dates = "monthly";
  # nix.gc.options = "--delete-old";

  nixpkgs.config.allowUnfree = true;

  boot.cleanTmpDir = true;

  networking.hostName = "laptop";

  time.timeZone = "Europe/Zurich";

  console.keyMap = "us";

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";

}
