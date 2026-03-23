{ pkgs, ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
    ];

    brews = [
    ];

    casks = [
      "discord"
      "iina"
      "iterm2"
      "keka"
      "obs"
      "obsidian"
      "spotify"
      "telegram"
      "termius"
      "utm"
      "visual-studio-code"
      "whatsapp"
      "zed"
      "onlyoffice"
      "blip"
      "pearcleaner"
      "xquartz"
      "ghostty"
    ];
  };
}
