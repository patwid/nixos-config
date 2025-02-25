{ pkgs, osConfig, ... }:

let
  inherit (osConfig) colors;
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      let g:netrw_banner=0
      set clipboard=unnamedplus
      set hidden
      set laststatus=1
      set shortmess+=I
      set notermguicolors

      augroup highlight_override
        autocmd!
        autocmd ColorScheme * highlight WinSeparator ctermbg=None
      augroup END

      set background=${colors.variant}
      colorscheme simple

      " https://github.com/vim/colorschemes/wiki/How-to-override-a-colorscheme%3F
      command! Inspect echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    '';
    plugins = with pkgs.vimPlugins; [
      fugitive
      vim-nix
      vim-simple
      fzf-vim
      # fzfWrapper # TODO: what does fzfWrapper do?
    ];
  };
}
