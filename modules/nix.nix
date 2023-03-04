{ lib, pkgs, args, ... }:
let
  localpkgs = import ../overlays/localpkgs.nix { inherit lib pkgs; } ;
in {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc.automatic = true;
  nix.gc.dates = "monthly";
  # nix.gc.options = "--delete-old";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ localpkgs ];

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flags = [
      "--flake" "/home/${args.user}/.config/nixos#laptop"
    ];
  };
}
