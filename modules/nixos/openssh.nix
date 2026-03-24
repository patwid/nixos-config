{
  config,
  lib,
  ...
}:
let
  inherit (config) user work;
in
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${user.name} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxXYugJIENGOXJIY11n2H+yHbfBLoh1pByszOe1s2BQ patwid@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKDwzQD/7hBZakOKm3Fxv4r8qz/y0MiDxuJ2X8hj8sJn patwid@htpc"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINpXEq+FIUxQkyX8yhm6jrXDJNZQn6H6nifNY5KsUZgh patwid@laptop"
    ];
  };

  home-manager.users.${user.name} = lib.mkIf work.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        qs-auto-test = {
          proxyJump = "ergon";
          hostname = "10.139.70.5";
          user = "testing-user";
        };

        hildegard = {
          proxyJump = "ergon";
          hostname = "10.139.70.10";
          user = "testing-user";
        };

        heidi = {
          proxyJump = "ergon";
          hostname = "10.139.70.15";
          user = "testing-user";
        };

        helena = {
          proxyJump = "ergon";
          hostname = "10.139.70.20";
          user = "testing-user";
        };

        # Thomas/Aaron
        axenita-tower-remote-vm-1 = {
          proxyJump = "ergon";
          hostname = "10.139.70.203";
          user = "testing-user";
        };

        # Jan
        axenita-tower-remote-vm-2 = {
          proxyJump = "ergon";
          hostname = "10.139.70.204";
          user = "testing-user";
        };

        # Patrick
        axenita-tower-remote-vm-3 = {
          proxyJump = "ergon";
          hostname = "10.139.70.205";
          user = "testing-user";
        };

        ergon = {
          hostname = "linux.ergon.ch";
        };
      };
    };
  };
}
