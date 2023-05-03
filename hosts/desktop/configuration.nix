{ nixos-hardware, ... }:
{
  imports = with nixos-hardware.nixosModules; [
    common-cpu-intel
    common-pc
    common-pc-ssd
  ];

  bootloader = "systemdboot";
  home = true;
  work.enable = true;
  work.remote = true;
}
