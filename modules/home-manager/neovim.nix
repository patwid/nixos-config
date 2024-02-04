{ nixosConfig, pkgs, ... }:
let
  inherit (nixosConfig) colors;
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
      set guicursor+=a:blinkon700
      set hidden
      set laststatus=1
      set shortmess+=I

      augroup default_override
        autocmd!
        autocmd ColorScheme default highlight Directory ctermfg=cyan
        autocmd ColorScheme default highlight MoreMsg ctermfg=green
        autocmd ColorScheme default highlight PreProc ctermfg=blue
        autocmd ColorScheme default highlight Question ctermfg=green
        autocmd ColorScheme default highlight Special ctermfg=magenta
        autocmd ColorScheme default highlight SpecialKey ctermfg=cyan
        autocmd ColorScheme default highlight Title ctermfg=magenta
        autocmd ColorScheme default highlight Type ctermfg=green
        autocmd ColorScheme default highlight Underlined ctermfg=blue
        autocmd ColorScheme default highlight WarningMsg ctermfg=magenta

        autocmd ColorScheme default highlight! link DiffDelete SpellLocal
        autocmd ColorScheme default highlight! link NvimInternalError Error
        autocmd ColorScheme default highlight! link PmenuThumb TabLineFill
      augroup END

      augroup highlight_override
        autocmd!
        autocmd ColorScheme * highlight WinSeparator ctermbg=None
      augroup END

      colorscheme ${colors.variant}

      " https://github.com/vim/colorschemes/wiki/How-to-override-a-colorscheme%3F
      command! Inspect echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    '';
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      fugitive
      vim-nix
      vim-simple
      fzf-vim
      # fzfWrapper # TODO: what does fzfWrapper do?
    ];
  };
}
