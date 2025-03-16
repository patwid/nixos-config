{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "vis";
  };

  home.packages = builtins.attrValues {
    inherit (pkgs) vis;
  };

  programs.bash.shellAliases = {
    "vi" = "vis";
    "vim" = "vis";
  };

  xdg.configFile."vis" = {
    source = ./vis;
    recursive = true;
  };
}
