{ config, lib, nixos-apple-silicon, ... }:
let
  inherit (config) apple-silicon;
in
{
  options.apple-silicon = lib.mkEnableOption { };

  imports = [
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  config = lib.mkIf (apple-silicon) {
    boot.loader.efi.canTouchEfiVariables = false;
    boot.loader.efi.efiSysMountPoint = "/boot";

    hardware.asahi.peripheralFirmwareDirectory = ../../firmware;
    hardware.asahi.useExperimentalGPUDriver = true;

    nixpkgs.overlays = [
      nixos-apple-silicon.overlays.apple-silicon-overlay
    ];

    system.autoUpgrade.flags = [ "--impure" ];
  };
}
