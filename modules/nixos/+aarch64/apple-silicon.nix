{ config, lib, nixos-apple-silicon, hostname, ... }:
let
  inherit (config) appleSilicon;
  inherit (config.nixpkgs) hostPlatform;
in
{
  options.appleSilicon.enable = lib.mkEnableOption { };

  # XXX: conditional import causes infite recursion error
  # imports = lib.optionals (apple-silicon) [
  #   nixos-apple-silicon.nixosModules.apple-silicon-support
  # ];
  imports = [
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  config = lib.mkIf (appleSilicon.enable) {
    hardware.asahi.peripheralFirmwareDirectory = ../../../hosts/${hostPlatform.system}/${hostname}/firmware;
    hardware.asahi.useExperimentalGPUDriver = true;

    nixpkgs.overlays = [
      nixos-apple-silicon.overlays.apple-silicon-overlay
    ];

    boot.loader.efi.canTouchEfiVariables = false;
    boot.loader.efi.efiSysMountPoint = "/boot";

    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
      options hid_apple swap_opt_cmd=1
      options hid_apple swap_fn_leftctrl=1
    '';

    system.autoUpgrade.flags = [ "--impure" ];
  };
}
