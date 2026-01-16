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

  vmopts =
    ''
      -Dawt.toolkit.name=WLToolkit
    ''
    + ideaExtraVmopts;

  # Overriding vmopts of idea pkg does not seem to work
  idea = pkgs.jetbrains.idea.override {
    inherit vmopts;
  };

  ideaPlugins = builtins.attrValues {
    inherit (plugins.${system}.idea.${idea.version}) IdeaVIM;
  };
in
lib.mkIf (work.enable) {
  # Workaround because overriding vmopts does not work
  home.sessionVariables = {
    IDEA_VM_OPTIONS = vmopts |> lib.splitString "\n" |> lib.concatStringsSep " ";
  };

  home.packages = [
    (pkgs.jetbrains.plugins.addPlugins idea ideaPlugins)
  ];

  xdg.configFile."ideavim/ideavimrc".text = ''
    set clipboard+=unnamedplus,ideaput
    set ideajoin
  '';
}
