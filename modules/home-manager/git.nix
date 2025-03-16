{ osConfig, ... }:
let
  inherit (osConfig) work;
in
{
  programs.git = {
    enable = true;
    userName = "Patrick Widmer";
    userEmail = if work.enable then "patrick.widmer@ergon.ch" else "patrick.widmer@tbwnet.ch";

    lfs.enable = true;
    extraConfig = {
      column.ui = "auto";
      branch.sort = "-committeredate";
      tag.sort = "version:refname";
      init.defaultBranch = "master";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      fetch = {
        all = true;
        prune = true;
        pruneTags = true;
      };

      help.autocorrect = "prompt";
      commit.verbose = true;

      # Reuse recorded resolutions
      rerere = {
        enabled = true;
        autoupdate = true;
      };

      core.editor = "vis";
      # core.excludesfile = "~/.gitignore"; # global gitignore

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      # merge.conflictstyle = zdiff3;

      # Resources:
      # - https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      # - https://blog.gitbutler.com/how-git-core-devs-configure-git/
    };
  };
}
