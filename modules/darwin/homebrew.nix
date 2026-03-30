{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [
      "discord"
      "iina"
      "iterm2"
      "keka"
      "obsidian"
      "spotify"
      "telegram"
      "termius"
      "utm"
      "visual-studio-code"
      "whatsapp"
      "zed"
      "blip"
      "pearcleaner"
      "xquartz"
      "font-monocraft"
      "zen"
      "prismlauncher"
      "font-departure-mono"
    ];
  };
}
