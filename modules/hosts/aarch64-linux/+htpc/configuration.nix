{ ... }:
{
  appleSilicon.enable = true;
  home.enable = true;
  terminal.fontsize = 13;

  outputs = {
    HDMI-A-1 = {
      scale = 2;
    };
  };

  boot.tmp.useTmpfs = false;

  system.stateVersion = "23.05";
}
