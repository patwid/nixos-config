{
  inputs,
  config,
  ...
}:
let
  inherit (inputs)
    self
    nixpkgs
    nixpkgs-stable
    ;
  inherit (config) user;
in
{
  networking.nftables.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
  nix.settings.auto-optimise-store = true;
  nix.settings.keep-outputs = true;
  nix.settings.keep-derivations = true;
  nix.settings.trusted-users = [
    "root"
    user.name
    "@wheel"
  ];

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  # nix.gc.options = "--delete-old";

  nix.registry = {
    nixpkgs.flake = nixpkgs;
    stable.flake = nixpkgs-stable;
    self.flake = self;
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = builtins.attrValues self.overlays;

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    settings.global.warn_timeout = "1h";
  };
}
