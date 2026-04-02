{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [
      "discord"
      "telegram"

      "visual-studio-code"
      "zed"
      "obsidian"
      "termius"
      "iterm2"
      "utm"
      "xquartz"
      "claude"
      "protonvpn"

      "spotify"
      "whatsapp"
      "prismlauncher"

      "iina"
      "keka"
      "blip"
      "pearcleaner"

      "font-monocraft"
      "font-departure-mono"
    ];
  };
}
