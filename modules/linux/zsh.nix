{ ... }: {
  programs.zsh.shellAliases = {
    nixb = "sudo nixos-rebuild switch --flake ~/.config/nix#dam-linux";
    nixu = "nix flake update ~/.config/nix && sudo nixos-rebuild switch --flake ~/.config/nix#dam-linux";
  };
}
