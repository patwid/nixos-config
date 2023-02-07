{ pkgs, app, url, ... }:

pkgs.writeShellScriptBin "${app}" ''
  ${pkgs.chromium}/bin/chromium --app='${url}'
''
