{ ... }:
{
  appleSilicon.enable = true;
  laptop = true;
  home.enable = true;
  work.enable = true;
  work.remote = true;

  outputs = {
    eDP-1 = {
      scale = 1.4;
    };
  };

  boot.tmp.useTmpfs = false;

  system.stateVersion = "23.11";
}
