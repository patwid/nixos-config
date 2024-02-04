{ vimUtils }:

vimUtils.buildVimPlugin {
  pname = "vim-simple";
  version = "unstable-2024-02-04";
  src = ./.;
}
