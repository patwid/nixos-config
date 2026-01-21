{ pkgs, ... }:
{
  environment = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    systemPackages = builtins.attrValues {
      inherit (pkgs) neovim;
    };
  };
}
