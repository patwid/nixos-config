{ vimUtils }:

vimUtils.buildVimPlugin {
  pname = "vim-simple";
  version = "0-unstable-2024-02-04";
  src = ./.;
}
