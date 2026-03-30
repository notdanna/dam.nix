{ pkgs, lib, inputs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-linux";
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelParams = [ "appledrm.show_notch=1" ];

  hardware.asahi = {
    setupAsahiSound = true;
    peripheralFirmwareDirectory = ./firmware;
  };

  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  services.upower.enable = true;
  services.dbus.enable = true;
  services.power-profiles-daemon.enable = true;

  users.users.dam = {
    isNormalUser = true;
    home = "/home/dam";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };

  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.niri.enable = true;
  services.tailscale.enable = true;
  security.pam.services.swaylock = {};

  environment.systemPackages = with pkgs; [
    git
    neovim
    curl
    brightnessctl
    inputs.zen-browser.packages.aarch64-linux.default
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = lib.mkForce [ "gtk" ];
    config.niri.default = lib.mkForce [ "gtk" ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    departure-mono
  ];

  system.stateVersion = "24.11";

}