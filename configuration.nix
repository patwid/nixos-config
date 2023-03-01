{ config, lib, pkgs, args, ... }:
let
  localpkgs = import ./overlays/localpkgs.nix { inherit lib pkgs; } ;
in {
  imports = [
    ./hardware-configuration.nix
    ./modules/home.nix

    ./modules/doas.nix
    ./modules/fonts.nix
    ./modules/localization.nix
    ./modules/networkmanager.nix
    ./modules/openssh.nix
    ./modules/shares-home.nix
    ./modules/systemdboot.nix
    ./modules/users.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc.automatic = true;
  nix.gc.dates = "monthly";
  # nix.gc.options = "--delete-old";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ localpkgs ];

  boot.cleanTmpDir = true;

  networking.hostName = "${args.hostname}";

  time.timeZone = "Europe/Zurich";

  console.keyMap = "us";

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flags = [
      "--flake" "/home/${args.user}/.config/nixos#laptop"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
