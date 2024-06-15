{ osConfig, ... }:
let
  inherit (osConfig) work;
in
{
  programs.git = {
    enable = true;
    userName = "Patrick Widmer";
    userEmail =
      if work.enable then
        "patrick.widmer@ergon.ch"
      else
        "patrick.widmer@tbwnet.ch";

    hooks = {
      pre-commit = ./pre-commit;
    };
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "master";
      core.editor = "nvim";
      rebase.autoStash = true;
      rerere.enabled = true;
    };
  };
}
