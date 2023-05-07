{ config, lib, nixos-apple-silicon, ... }:
let
  inherit (config) apple-silicon;
in
{
  options.apple-silicon = lib.mkEnableOption { };

  config = lib.mkIf (apple-silicon) {
    nixpkgs.overlays = [
      nixos-apple-silicon.overlays.apple-silicon-overlay
    ];

    hardware.asahi.peripheralFirmwareDirectory = ../firmware;
    hardware.asahi.useExperimentalGPUDriver = true;

    system.autoUpgrade.flags = [ "--impure" ];
  };
}
