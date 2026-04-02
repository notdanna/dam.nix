{ config, pkgs, ... }:

{
  users.users.cloudflared = {
    isSystemUser = true;
    group = "cloudflared";
  };
  users.groups.cloudflared = {};

  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Tunnel (Cloud-managed)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
      EnvironmentFile = "/run/cloudflare.env";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
      RestartSec = "5";
    };
  };
}
