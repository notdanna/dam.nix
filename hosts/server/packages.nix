{ config, pkgs, ... }:

{
  # --- LISTA DE PAQUETES ---
  environment.systemPackages = with pkgs; [
    # Herramientas base
    git 
    curl 
    neovim 
    wget 
    btop 
    tmux
    fastfetch 
    ranger 
    tldr 
    eza 
    bat
    fzf
    spotify-player
    tree
    ripgrep 
    cloudflared
    python3
    python3Packages.requests
    python3Packages.pillow
    ffmpeg
    zip
    unzip
    p7zip
    jq

    rofi
    wttrbar
    
    # Complementos de Zsh
    zsh-powerlevel10k 
    meslo-lgs-nf
  ];

  # --- FUENTES ---
  fonts.packages = with pkgs; [ 
    nerd-fonts.meslo-lg 
  ];

  # --- CONFIGURACIÓN DE SHELLS (ZSH & ZOXIDE) ---
  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      # Sistema
      update = "sudo nixos-rebuild switch";
      conf = "sudo nvim /etc/nixos/configuration.nix";
      garc = "sudo nix-collect-garbage -d";
      pkgs = "nix-shell -p";
      
      # Utilidades
      ll = "eza -l --icons";
      ls = "eza --icons";
      cl = "clear";
      nv = "nvim";
      ff = "fastfetch -c /home/dam/.config/fastfetch/presets/nyarch.jsonc";
      
      # Git
      gc = "git clone";
      gp = "git pull";
      gs = "git status";
      ga = "git add";
      gf = "git fetch";
      
      # Docker
      dps = "docker ps";
      dlogs = "docker logs -f";
      dstop = "docker stop $(docker ps -q)";
    };

    interactiveShellInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      eval "$(zoxide init zsh --cmd cd)"
    '';
  };

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
