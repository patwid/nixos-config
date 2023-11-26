{ writeShellApplication, coreutils, foot, fzf }:

writeShellApplication {
  name = "menu";
  runtimeInputs = [ coreutils foot fzf ];
  text = ''
    in_pipe="$XDG_RUNTIME_DIR/menu-in.$$.pipe"
    out_pipe="$XDG_RUNTIME_DIR/menu-out.$$.pipe"

    mkfifo "$in_pipe" "$out_pipe"
    trap 'rm -f $in_pipe $out_pipe' EXIT

    export FZF_DEFAULT_OPTS="--reverse --no-info"
    foot --app-id=menu sh -x -c "fzf <$in_pipe >$out_pipe" &

    cat >"$in_pipe"
    cat <"$out_pipe"
  '';
}
