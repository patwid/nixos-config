{ config, lib, ... }:
lib.mkIf (config.boot.loader.systemd-boot.enable) {
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
}
