# ✦ dam.nix

my nix config for all my machines (ᵕ—ᴗ—)

## ˖ ࣪⊹ systems

| host | os | arch |
|------|----|------|
| `dam` | macOS | aarch64-darwin |
| `dam-linux` | NixOS · niri | aarch64-linux (Apple Silicon) |
| `damx` | NixOS · server | x86_64-linux |

## ˖ ࣪⊹ structure

```
├── hosts/
│   ├── darwin/      macOS
│   ├── linux/       personal linux (asahi)
│   └── server/      home server
├── modules/
│   ├── common/      shared things
│   ├── darwin/      yabai · skhd · homebrew
│   ├── linux/       niri · waybar · foot
│   └── server/
│       └── hub/     jellyfin · immich · nextcloud · navidrome · cloudflare
└── secrets.yaml     ciphered with age/sops ༄
```

## ˖ ࣪⊹ apply

```bash
# mac
darwin-rebuild switch --flake .#dam

# linux personal
sudo nixos-rebuild switch --flake .#dam-linux

# servidor
sudo nixos-rebuild switch --flake .#damx
```

## ˖ ࣪⊹ secrets

the secrets are ciphered with [sops-nix](https://github.com/mic92/sops-nix) + age.  

`secrets.yaml` (˶ᵔ ᵕ ᵔ˶)

## ˖ ࣪⊹ recovery

> here it's my private key `~/.config/sops/age/keys.txt` ༄  

### New instalation on MacOS

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh

nix run nix-darwin -- switch --flake github:notdanna/dam.nix#dam

mkdir -p ~/.config/sops/age && nano ~/.config/sops/age/keys.txt && chmod 600 ~/.config/sops/age/keys.txt
```

### New linux aarch64(Apple Silicon)
```bash
sudo nixos-rebuild switch --flake github:notdanna/dam.nix#dam-linux

mkdir -p ~/.config/sops/age && nano ~/.config/sops/age/keys.txt && chmod 600 ~/.config/sops/age/keys.txt
```

### New server
```bash
# from the mac, copy the private key:
scp ~/.config/sops/age/keys.txt dam@<ip>:/tmp/keys.txt
# in the server:
sudo mkdir -p /root/.config/sops/age

sudo mv /tmp/keys.txt /root/.config/sops/age/keys.txt && sudo chmod 600 /root/.config/sops/age/keys.txt

sudo nixos-rebuild switch --flake github:notdanna/dam.nix#damx
```

#### Edit secrets
```bash
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt  # add to .zshrc
sops ~/dam.nix/secrets.yaml
```
