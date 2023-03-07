{ config, lib, pkgs, nur, ... }:
let
  inherit (config) user;
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc.automatic = true;
  nix.gc.dates = "monthly";
  # nix.gc.options = "--delete-old";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import ../overlays/localpkgs.nix { inherit lib pkgs; })
    (import ../overlays/nur.nix { inherit nur; })
  ];

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "/home/${user.name}/.config/nixos#${config.networking.hostName}";
    flags = [ "--recreate-lock-file" ];
  };

  system.activationScripts = {
    linkFlakeConfig = ''
      ln -sfn /home/${user.name}/.config/nixos/flake.nix /etc/nixos/flake.nix
    '';
  };
}
