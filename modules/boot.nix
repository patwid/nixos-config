{ config, lib, ... }:
let
  inherit (config.tmp) useTmpfs;
in
{
  options.tmp.useTmpfs = lib.mkEnableOption {};

  config = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 10;
    boot.loader.efi.efiSysMountPoint = lib.mkDefault "/boot/efi";
    boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

    boot.tmp.useTmpfs = useTmpfs;
    boot.tmp.cleanOnBoot = !useTmpfs;
  };
}
