{ nixos-hardware, ... }:
{
  imports = with nixos-hardware.nixosModules; [
    lenovo-thinkpad-t460s
    common-pc-laptop-ssd
  ];

  bootloader = "systemdboot";
  laptop = true;
  home = true;
  work.enable = true;
  work.remote = true;
}
