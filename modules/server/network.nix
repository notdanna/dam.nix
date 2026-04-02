{ config, pkgs, ... }:

{
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