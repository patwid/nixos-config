{ config, lib, ... }:
let
  inherit (config) apple-silicon;
in
lib.mkMerge [
  {
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 5;
    boot.loader.efi.canTouchEfiVariables = !apple-silicon;

    boot.tmp.useTmpfs = !apple-silicon;
    boot.tmp.cleanOnBoot = apple-silicon;
  }

  (lib.mkIf (!apple-silicon) {
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
  })
]
