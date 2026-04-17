{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [
      # "discord"
      "telegram"
      "vesktop"
      "alcove"

      "visual-studio-code"
      "zed"
      "nextcloud"
      "obsidian"
      # "termius"
      "iterm2"
      "utm"
      "xquartz"
      "claude"
      "protonvpn"
      "tailscale-app"

      # "spotify"
      "whatsapp"
      # "prismlauncher"
      # "arc"
      
      "keka"
      "blip"
      "pearcleaner"

      "font-monocraft"
      "font-departure-mono"
    ];
  };
}
