{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [
      "telegram"
      "vesktop"
      "alcove"

      "visual-studio-code"
      "zed"
      "nextcloud"
      "obsidian"
      "iterm2"
      "utm"
      "xquartz"
      "claude"
      "protonvpn"
      "tailscale-app"

      "spotify"
      "whatsapp"
      # "prismlauncher"
      "arc"
      
      "iina"
      "keka"
      "blip"
      "pearcleaner"

      "font-monocraft"
      "font-departure-mono"
    ];
  };
}
