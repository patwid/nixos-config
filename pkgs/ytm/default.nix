{ writeShellApplication, mpv }:

writeShellApplication {
  name = "ytm";
  runtimeInputs = [ mpv ];
  text = ''
    query=$*
    if [ -n "$query" ]; then
      exec mpv https://music.youtube.com/search?q="$query"
    fi
  '';
}
