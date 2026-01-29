{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (inputs) self nixos-apple-silicon;
  inherit (config) appleSilicon;
  inherit (config.nixpkgs) hostPlatform;
  inherit (config.networking) hostName;
in
{
  options.appleSilicon.enable = lib.mkEnableOption { };

  imports = [
    nixos-apple-silicon.nixosModules.apple-silicon-support
  ];

  config = lib.mkIf (appleSilicon.enable) {
    hardware.asahi.peripheralFirmwareDirectory = ../../hosts/${hostPlatform.system}/+${hostName}/firmware;

    hardware.asahi.overlay = self.overlays.apple-silicon;

    boot.loader.efi.canTouchEfiVariables = false;
    boot.loader.efi.efiSysMountPoint = "/boot";

    boot.kernelParams = [ "appledrm.show_notch=1" ];

    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
      options hid_apple swap_opt_cmd=1
      options hid_apple swap_fn_leftctrl=1
    '';

    boot.m1n1CustomLogo = ./empty.png;
  };
}
