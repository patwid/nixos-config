{ nixos-hardware, ... }:
{
  imports = [
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  appleSilicon.enable = true;
  home.enable = true;
  terminal.fontsize = 13;

  outputScales = {
    HDMI-A-1 = "2";
  };

  boot.tmp.useTmpfs = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}
