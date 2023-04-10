{ args, config, lib, pkgs, nur, ... }:
let
  inherit (args) user;
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc.automatic = true;
  nix.gc.dates = "monthly";
  # nix.gc.options = "--delete-old";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ../overlays { inherit lib pkgs nur; };

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "/home/${user}/.config/nixos#${config.networking.hostName}";
    flags = [ "--recreate-lock-file" ];
  };

  system.activationScripts = {
    linkFlakeConfig = ''
      ln -sfn /home/${user}/.config/nixos/flake.nix /etc/nixos/flake.nix
    '';
  };
}
