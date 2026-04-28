{ config, pkgs, ... }:

{
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://vault.notdam.dev";
      ROCKET_PORT = 8222;
      ROCKET_ADDRESS = "127.0.0.1";
      SIGNUPS_ALLOWED = false;
      ADMIN_TOKEN = "VBdZ/gCe++CiDR3eiZiMAcbpuApKJ+3sv6sTrHL2hr2ALjzd2AkATktXIKInck+2"; 
    };
  };
}
