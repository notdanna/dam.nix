{ ... }: {
  programs.zsh.shellAliases = {
    nxb = "sudo darwin-rebuild switch --flake ~/dam.nix#dam";
    nxu = "nix flake update ~/dam.nix && sudo darwin-rebuild switch --flake ~/dam.nix#dam";
  };
}
