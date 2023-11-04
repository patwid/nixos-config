{ args, ... }:
let
  inherit (args) user;
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
