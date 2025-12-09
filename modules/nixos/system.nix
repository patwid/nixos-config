{
  self,
  config,
  pkgs,
  nixpkgs,
  nixpkgs-stable,
  nur,
  hostname,
  wrappers,
  lib,
  ...
}@inputs:
let
  inherit (config) user;

  wrapperOverlay = import ../wrappers/overlay.nix { inherit config lib wrappers; };
in
{
  networking.hostName = hostname;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
  nix.settings.auto-optimise-store = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  # nix.gc.options = "--delete-old";

  nix.registry = {
    nixpkgs.flake = nixpkgs;
    stable.flake = nixpkgs-stable;
    self.flake = self;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    nur.overlays.default
    wrapperOverlay
    self.overlays.default
  ];

  system.autoUpgrade = {
    enable = false;
    dates = "weekly";
    flake = "/home/${user.name}/.config/nixos";
    flags = [ "--recreate-lock-file" ];
  };

  system.activationScripts = {
    linkFlakeConfig = ''
      ln -sfn /home/${user.name}/.config/nixos/flake.nix /etc/nixos/flake.nix
    '';
  };
}
