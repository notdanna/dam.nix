{ pkgs, ... }: {
  home.username = "dam";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/dam" else "/home/dam";
  
  home.stateVersion = "24.11";

  imports = [
    ./modules/common/zsh.nix
    ./modules/common/git.nix
    ./modules/common/packages.nix
  ];

  programs.home-manager.enable = true;
  programs.git.signing.format = "openpgp";
}