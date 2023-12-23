{ config, ... }:
let
  inherit (config) user;
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
}
