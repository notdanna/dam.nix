{ ... }: {
  programs.zsh.shellAliases = {
    nxb = "sudo nixos-rebuild switch --flake ~/dam.nix#damx";
    nxu = "nix flake update ~/.config/nix && sudo nixos-rebuild switch --flake ~/.config/nix#damx";
  };
}
