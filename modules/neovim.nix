{ config, pkgs, ... }:
let
  inherit (config) user;
in
{
  environment.variables = {
    EDITOR = "nvim";
  };

  programs.neovim.enable = true;

  home-manager.users.${user} = {
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

        augroup Colors
          autocmd!
          autocmd Syntax * call SetColors()
        augroup END

        function! SetColors() abort
          if &background ==# "dark"
            highlight Directory ctermfg=cyan
            highlight SpecialKey ctermfg=cyan
            highlight Type ctermfg=green
            highlight PreProc ctermfg=blue
          endif
          highlight WinSeparator ctermbg=None
        endfunction
      '';
      plugins = with pkgs.vimPlugins; [
        editorconfig-vim
        fugitive
        vim-nix
        fzf-vim
        # fzfWrapper # TODO: what does fzfWrapper do?
      ];
    };
  };
}
