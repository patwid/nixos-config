{ fetchFromSourcehut, vimUtils }:

vimUtils.buildVimPlugin {
  pname = "vim-paige";
  version = "unstable-2020-11-28";

  src = fetchFromSourcehut {
    owner = "~leon_plickat";
    repo = "paige";
    rev = "0d72c3814da3cc01d4435deaa6168fa913c694fd";
    hash = "sha256-tozoGnzKEaph6TsDfWwlmgMVuoagWSt37nIvOmuZ9ec=";
  };
}
