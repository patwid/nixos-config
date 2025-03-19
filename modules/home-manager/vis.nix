{ osConfig, pkgs, ... }:

let
  inherit (osConfig.colors) variant;
in
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

  xdg.configFile."vis/visrc.lua".text = ''
    require('vis')
    
    vis.events.subscribe(vis.events.INIT, function()
    	vis:command('set theme ${variant}')
    end)
  '';
}
