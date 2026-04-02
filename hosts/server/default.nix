{ config, lib, pkgs, ... }:

{
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
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSDs="
  ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../modules/server/hardware.nix
    ../../modules/server/network.nix
    ../../modules/server/system.nix
    #../../modules/server/minecraft.nix

    ../../modules/server/hub/nextcloud.nix
    ../../modules/server/hub/cloudflare.nix

    ../../modules/server/hub/immich.nix
    ../../modules/server/hub/jellyfin.nix
    ../../modules/server/hub/navidrome.nix

    ../../modules/server/hub/slskd.nix
    ../../modules/server/hub/qbittorrent.nix
    #../../modules/server/hub/kavita.nix
  ];

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

  system.stateVersion = "25.11";
}
