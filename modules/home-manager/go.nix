{ config, osConfig, ... }:
let
  inherit (config) xdg;
  inherit (osConfig) user;
in
{
  home.sessionVariables = {
    GOPATH = "${xdg.dataHome}/go";

    GOPROXY = "direct";
    GOSUMDB = "off";
    GOTELEMETRY = "off";
    GOTOOLCHAIN = "local";
  };
}
