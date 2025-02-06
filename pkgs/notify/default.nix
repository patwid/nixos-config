{
  writeShellApplication,
  libnotify,
  name ? "",
  summary ? "",
  body ? "",
}:

writeShellApplication {
  inherit name;
  runtimeInputs = [ libnotify ];
  text = ''
    exec notify-send '${summary}' '${body}'
  '';
}
