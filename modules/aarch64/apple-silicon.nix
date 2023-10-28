{ config, lib, nixos-apple-silicon, ... }:
let
  inherit (config) apple-silicon;
in
{
  imports = [
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  config = lib.mkIf (apple-silicon) {
    hardware.asahi.peripheralFirmwareDirectory = ../../firmware;
    hardware.asahi.useExperimentalGPUDriver = true;
    # hardware.asahi.pkgsSystem = "x86_64-linux";

    nixpkgs.overlays = [
      nixos-apple-silicon.overlays.apple-silicon-overlay
    ];

    system.autoUpgrade.flags = [ "--impure" ];
  };
}
