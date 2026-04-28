{ config, lib, pkgs, inputs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ ];

  services.resolved.enable = false;

  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../modules/server/secrets.nix
    ../../modules/server/nix.nix
    ../../modules/server/base.nix
    ../../modules/server/desktop.nix
    ../../modules/server/system.nix
    ../../modules/server/hub/networks.nix
    ../../modules/server/hub/nextcloud.nix
    ../../modules/server/hub/cloudflare.nix
    ../../modules/server/hub/immich.nix
    ../../modules/server/hub/jellyfin.nix
    ../../modules/server/hub/navidrome.nix
    ../../modules/server/hub/slskd.nix
    ../../modules/server/hub/qbittorrent.nix
    ../../modules/server/hub/kuma.nix
    ../../modules/server/hub/adguardhome.nix
    ../../modules/server/hub/glances.nix
    ../../modules/server/hub/hestia.nix
    ../../modules/server/hub/vaultwarden.nix
  ];

  system.stateVersion = "25.11";
}
