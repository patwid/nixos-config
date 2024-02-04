{ nixosConfig, ... }:
let
  inherit (nixosConfig) work;
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

    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "master";
      core.editor = "nvim";
      rerere.enabled = true;
    };
  };
}
