{
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.fzf ];

  programs.bash.interactiveShellInit = ''
    eval "$(${lib.getExe pkgs.fzf} --bash)"
  '';
}
