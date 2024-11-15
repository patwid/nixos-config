{ config, ... }:
let
  inherit (config) user;
in
{
  programs.git = {
    enable = true;

    config = {
      safe.directory = "/home/${user.name}/.config/nixos";
    };
  };
}
