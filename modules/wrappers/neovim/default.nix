{
  inputs,
  pkgs,
  ...
}:
let
  inherit (inputs) wrappers;
in
wrappers.wrappedModules.neovim.wrap {
  inherit pkgs;

  settings = {
    aliases = [
      "vi"
      "vim"
    ];
    config_directory = ./config;
  };

  specs.general = with pkgs.vimPlugins; [
    fugitive
    vim-nix
    vim-simple
    fzf-vim
    # fzfWrapper # TODO: what does fzfWrapper do?
  ];
}
