{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      let g:netrw_banner=0
      set clipboard=unnamedplus
      set guicursor+=a:blinkon700
      set hidden
      set laststatus=1
      set shortmess+=I

      augroup default_override
        autocmd!
        autocmd ColorScheme default highlight Directory ctermfg=cyan
        autocmd ColorScheme default highlight SpecialKey ctermfg=cyan
        autocmd ColorScheme default highlight Type ctermfg=green
        autocmd ColorScheme default highlight PreProc ctermfg=blue
        autocmd ColorScheme default highlight Question ctermfg=green
      augroup END

      augroup highlight_override
        autocmd!
        autocmd ColorScheme * highlight WinSeparator ctermbg=None
      augroup END

      colorscheme paige-system
    '';
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      fugitive
      vim-nix
      fzf-vim
      vim-paige
      # fzfWrapper # TODO: what does fzfWrapper do?
    ];
  };
}
