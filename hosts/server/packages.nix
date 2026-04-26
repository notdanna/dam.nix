{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    tldr
    cloudflared
    python3
    python3Packages.requests
    python3Packages.pillow
    zip
    unzip
    p7zip

    dmenu
    st
    xrandr
    qutebrowser

    zsh-powerlevel10k
    meslo-lgs-nf
  ];

  fonts.packages = with pkgs; [ 
    nerd-fonts.meslo-lg 
  ];

  system.activationScripts.nvim-config = {
    text = ''
      # Para el usuario dam
      mkdir -p /home/dam/.config
      ln -sfn /etc/nixos/nvim-config /home/dam/.config/nvim
      chown -R dam:users /home/dam/.config/nvim

      # Para root
      mkdir -p /root/.config
      ln -sfn /etc/nixos/nvim-config /root/.config/nvim
    '';
  };

}
