{ pkgs, ... }: {
  imports = [
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/yabai.nix
    ../../modules/darwin/skhd.nix
  ];

  system.primaryUser = "dam";
  nixpkgs.hostPlatform = "aarch64-darwin";
  
  users.users.dam = {
    name = "dam";
    home = "/Users/dam";
  };

  nix.enable = false;

  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.monaspace
  ];

  services.openssh.enable = true;
  programs.zsh.enable = true;
  system.stateVersion = 5;
}
