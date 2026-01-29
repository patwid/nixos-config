{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (inputs)
    self
    nixpkgs
    nixpkgs-stable
    nur
    ;
  inherit (config) user;

  wrapperOverlay = import ../_wrappers/overlay.nix {
    inherit inputs config lib;
  };
in
{
  networking.nftables.enable = true;

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
  ]
  ++ builtins.attrValues self.overlays
  ++ [
    wrapperOverlay
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
