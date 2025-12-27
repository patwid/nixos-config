{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    package = pkgs.gitWrapped;
  };
}
