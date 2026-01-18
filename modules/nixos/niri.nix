{ lib, pkgs, ... }:
{
  options = {
    outputs = lib.mkOption {
      type = with lib; types.attrs;
      default = { };
    };
  };
  config = {
    programs = {
      niri = {
        enable = true;
      };

      bash = {
        loginShellInit = ''
          if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
            exec niri-session -l >/dev/null 2>&1
          fi
        '';
      };
    };

    environment.systemPackages = builtins.attrValues {
      inherit (pkgs) xwayland-satellite;
    };
  };
}
