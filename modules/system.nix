{ args, config, pkgs, nixpkgs, ... }@attrs:
let
  inherit (args) user hostname;
in
{
  networking.hostName = hostname;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  # nix.gc.options = "--delete-old";

  nix.registry.nixpkgs.flake = nixpkgs;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ../overlays attrs;

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
