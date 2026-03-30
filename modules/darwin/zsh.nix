{ ... }: {
  programs.zsh.shellAliases = {
    nxb = "sudo darwin-rebuild switch --flake ~/.config/nix#dam";
    nxu = "nix flake update ~/.config/nix && sudo darwin-rebuild switch --flake ~/.config/nix#dam";
  };
}
