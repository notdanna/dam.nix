{ config, lib, pkgs, inputs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  # Agrega aquí librerías básicas si es necesario, 
  # pero usualmente solo activar el programa basta para VS Code.
  ];


  # --- IMPORTS ---
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
  ];

  system.stateVersion = "25.11";
}
