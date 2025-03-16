{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "vis";
  };

  home.packages = builtins.attrValues {
    inherit (pkgs) vis;
  };
}
