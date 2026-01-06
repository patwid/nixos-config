{
  inputs,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  inherit (osConfig) work ideaExtraVmopts;
  inherit (pkgs.stdenv.hostPlatform) system;
  inherit (inputs.nix-jetbrains-plugins) plugins;

  idea = pkgs.jetbrains.idea.override {
    vmopts =
      ''
        -Dawt.toolkit.name=WLToolkit
      ''
      + ideaExtraVmopts;
  };

  ideaPlugins = builtins.attrValues {
    inherit (plugins.${system}.idea.${idea.version}) IdeaVIM;
  };
in
lib.mkIf (work.enable) {
  home.packages = [
    (pkgs.jetbrains.plugins.addPlugins idea ideaPlugins)
  ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
    set ideajoin
  '';
}
