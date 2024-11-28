{ writeShellApplication, mpv }:

writeShellApplication {
  name = "ytm";
  runtimeInputs = [ mpv ];
  text = ''
    exec mpv https://music.youtube.com/search?q="$*"
  '';
}
