{ lib, ... }:

{
  programs.zsh.initContent = lib.mkAfter ''
    # SSH agent
    if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
      if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent -t 4h > "$XDG_RUNTIME_DIR/ssh-agent.env"
      fi
      source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
    fi
  '';

  programs.git.ignores = [
    "*~"
    ".nfs*"
  ];
}
