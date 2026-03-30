{ ... }: {
  programs.zsh.shellAliases = {
    nxb = "sudo nixos-rebuild switch --flake ~/.config/nix#dam-linux";
    nxu = "nix flake update ~/.config/nix && sudo nixos-rebuild switch --flake ~/.config/nix#dam-linux";
  };
}
