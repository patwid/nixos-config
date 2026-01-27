{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (inputs) nixos-apple-silicon;
  inherit (config) appleSilicon;
  inherit (config.nixpkgs) hostPlatform;
  inherit (config.networking) hostName;
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
    hardware.asahi.peripheralFirmwareDirectory = ../../../hosts/${hostPlatform.system}/${hostName}/firmware;

    hardware.asahi.overlay = lib.composeManyExtensions [
      nixos-apple-silicon.overlays.default

      (final: prev: {
        uboot-asahi = prev.uboot-asahi.overrideAttrs (oldAttrs: {
          extraConfig = oldAttrs.extraConfig + ''
            CONFIG_VIDEO_LOGO=n
          '';
        });
      })
    ];

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
