{ ... }: {
  programs.zsh.shellAliases = {
    nixb = "sudo darwin-rebuild switch --flake ~/.config/nix#dam";
    nixu = "nix flake update ~/.config/nix && sudo darwin-rebuild switch --flake ~/.config/nix#dam";
  };
}
