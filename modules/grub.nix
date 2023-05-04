{ config, lib, ... }:
lib.mkIf (config.boot.loader.grub.enable) {
  boot.loader.grub.configurationLimit = 5;
  boot.loader.grub.device = "/dev/sda";
}
