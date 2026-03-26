{ pkgs, ... }:
{
  user.uid = 1795;
  group.name = "ergon";
  group.gid = 1111;
  work.enable = true;

  outputs = {
    DP-2 = {
      position = {
        _attrs = {
          x = 0;
          y = 0;
        };
      };
    };
  };

  services.printing.enable = true;

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) hplip;
  };

  system.stateVersion = "22.11";
}
