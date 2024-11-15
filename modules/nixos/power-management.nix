{ config, lib, ... }:
let
  inherit (config) laptop;
in
lib.mkIf (!laptop) {
  powerManagement.cpuFreqGovernor = "performance";
}
