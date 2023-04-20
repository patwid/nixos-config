{ writeShellApplication, chromium, app, url }:

writeShellApplication {
  name = "${app}";
  runtimeInputs = [ chromium ];
  text = ''
    chromium --app='${url}'
  '';
}
