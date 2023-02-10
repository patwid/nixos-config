{ writeShellScriptBin, chromium, app, url, ... }:

writeShellScriptBin "${app}" ''
  ${chromium}/bin/chromium --app='${url}'
''
