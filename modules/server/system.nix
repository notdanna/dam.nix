{ config, pkgs, ... }:

{
  # --- HARDWARE ---
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      libva-vdpau-driver
      libvdpau-va-gl
      mesa
      rocmPackages.clr.icd
    ];
  };

  services.udev.extraRules = ''
    KERNEL=="renderD128", MODE="0666"
  '';

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  # --- SYSTEM ---
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
  };

  # --- NETWORK ---
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "prohibit-password";
    };
  };

  networking.enableIPv6 = false;
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.allowedTCPPorts = [ 5032 3000 5000 ];
}