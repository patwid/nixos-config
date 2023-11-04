{ config, lib, nixos-apple-silicon, ... }:
let
  inherit (config) apple-silicon;
in
{
  options.apple-silicon = lib.mkEnableOption { };

  # XXX: conditional import causes infite recursion error
  # imports = lib.optionals (apple-silicon) [
  #   nixos-apple-silicon.nixosModules.apple-silicon-support
  # ];
  imports = [
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  config = lib.mkIf (apple-silicon) {
    hardware.asahi.peripheralFirmwareDirectory = ../../firmware;
    hardware.asahi.useExperimentalGPUDriver = true;

    nixpkgs.overlays = [
      nixos-apple-silicon.overlays.apple-silicon-overlay
    ];

    boot.loader.efi.canTouchEfiVariables = false;
    boot.loader.efi.efiSysMountPoint = "/boot";

    system.autoUpgrade.flags = [ "--impure" ];
  };
}
