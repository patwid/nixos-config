{ config, ... }:
let
  inherit (config) user;
in
{
  home-manager.users.${user} = {
    wayland.windowManager.sway = {
      config = {
        output.HDMI-A-1.scale = "2";
      };
    };
  };
}
