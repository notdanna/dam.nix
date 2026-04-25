{
  description = "Configuración Multiplataforma";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = inputs@{ nixpkgs, nix-darwin, home-manager, ... }: {
    darwinConfigurations."dam" = nix-darwin.lib.darwinSystem {
      modules = [
        { nixpkgs.hostPlatform = "aarch64-darwin"; }
        ./hosts/darwin/default.nix
        home-manager.darwinModules.home-manager {
          home-manager.users.dam = {
            imports = [ ./home.nix ./modules/darwin/zsh.nix ];
          };
        }
      ];
    };

    nixosConfigurations."damx" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./hosts/server/default.nix
        inputs.sops-nix.nixosModules.sops
        # inputs.nix-minecraft.nixosModules.minecraft-servers
        # { nixpkgs.overlays = [ inputs.nix-minecraft.overlay ]; }
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.dam = {
            imports = [
              ./home.nix
              ./modules/server/linux/fastfetch.nix
              ./modules/server/zsh.nix
	      ./modules/server/linux/packages.nix
            ];
          };
        }
      ];
    };
  };
}
