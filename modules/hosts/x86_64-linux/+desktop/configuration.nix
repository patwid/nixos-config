{ inputs, ... }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    common-cpu-intel
    common-pc
    common-pc-ssd
  ];

  home.enable = true;
  work.enable = true;
  work.remote = true;

  system.stateVersion = "22.11";
}
