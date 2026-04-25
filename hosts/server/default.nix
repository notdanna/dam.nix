{ config, lib, pkgs, ... }:

let
  # Definición de tus herramientas de suckless desde carpetas locales
  myDwm = pkgs.dwm.overrideAttrs (oldAttrs: {
    src = /home/dam/dawm.c/dots/dwm;
    preBuild = "make clean";
    makeFlags = [ "PREFIX=$(out)" ];
    buildInputs = with pkgs; [ 
      libinput 
      libX11 
      libXft 
      libXinerama 
    ];
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.pkg-config ];
  });

  myDmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
    src = /home/dam/dawm.c/dots/dmenu;
    preBuild = "make clean";
    makeFlags = [ "PREFIX=$(out)" ];
    buildInputs = with pkgs; [ 
      libX11 
      libXft 
      libXinerama 
    ];
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.pkg-config ];
  });
in
{
  # --- SECRETOS Y ENTORNO ---
  sops.defaultSopsFile = ../../secrets.yaml;
  sops.age.keyFile = "/root/.config/sops/age/keys.txt";

  sops.secrets = {
    cloudflare_token = {};
    nextcloud_mysql_root_password = {};
    nextcloud_mysql_password = {};
    slskd_password = {};
    slskd_slsk_password = {};
  };

  system.activationScripts.sops-env-files = {
    deps = [ "setupSecrets" ];
    text = ''
      printf 'TUNNEL_TOKEN=%s\n' "$(cat ${config.sops.secrets.cloudflare_token.path})" \
        > /run/cloudflare.env
      chmod 600 /run/cloudflare.env

      printf 'MYSQL_ROOT_PASSWORD=%s\nMYSQL_PASSWORD=%s\n' \
        "$(cat ${config.sops.secrets.nextcloud_mysql_root_password.path})" \
        "$(cat ${config.sops.secrets.nextcloud_mysql_password.path})" \
        > /run/nextcloud.env
      chmod 600 /run/nextcloud.env

      printf 'SLSKD_PASSWORD=%s\nSLSKD_SLSK_PASSWORD=%s\n' \
        "$(cat ${config.sops.secrets.slskd_password.path})" \
        "$(cat ${config.sops.secrets.slskd_slsk_password.path})" \
        > /run/slskd.env
      chmod 600 /run/slskd.env
    '';
  };

  # --- CONFIGURACIÓN DE NIX ---
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.substituters = lib.mkForce [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys = lib.mkForce [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- IMPORTS ---
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../modules/server/hardware.nix
    ../../modules/server/network.nix
    ../../modules/server/system.nix
    ../../modules/server/hub/networks.nix
    ../../modules/server/hub/nextcloud.nix
    ../../modules/server/hub/cloudflare.nix
    ../../modules/server/hub/immich.nix
    ../../modules/server/hub/jellyfin.nix
    ../../modules/server/hub/navidrome.nix
    ../../modules/server/hub/slskd.nix
    ../../modules/server/hub/qbittorrent.nix
  ];

  # --- SISTEMA BASE ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  networking.hostName = "damx";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "la-latin1";
  };

  users.users.dam = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Damian Franco";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
    initialPassword = "200469";
  };

  programs.zsh.enable = true;
  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # --- X11 Y DWM ---
  services.libinput.enable = true;
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    xkb.layout = "latam";
    windowManager.dwm = {
      enable = true;
      package = myDwm;
    };
  };

  # --- PAQUETES DEL SISTEMA ---
  environment.systemPackages = with pkgs; [
    git
    curl
    usbutils
    xrandr
    myDmenu
    # Otros paquetes que necesites para tu dwm
    flameshot
    xcolor
    pamixer
    brightnessctl
  ];

  system.stateVersion = "25.11";
}
