{
  inputs,
  config,
  ...
}:
let
  inherit (config) work;
  inherit (config.environment.sessionVariables) EDITOR;
in
{
  imports = [ inputs.nix-wrapper-modules.nixosModules.git ];

  wrappers.git = {
    enable = true;
    settings = {
      user.name = "Patrick Widmer";
      user.email = if work.enable then "patrick.widmer@ergon.ch" else "patrick.widmer@tbwnet.ch";

      column.ui = "auto";
      branch.sort = "-committerdate";
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

      core.editor = EDITOR;

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      # Resources:
      # - https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      # - https://blog.gitbutler.com/how-git-core-devs-configure-git/
    };
  };

  programs.git.lfs.enable = true;
}
