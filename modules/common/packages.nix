{ pkgs, ... }: {
  home.packages = with pkgs; [
    fd
    fzf
    bat
    eza
    fastfetch
    btop
    jq
    neovim
    ranger
    tmux
    tree
    zoxide
    kew
  ];
}
