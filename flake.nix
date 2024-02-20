{
  description = "NixOS Coding Club Bordeaux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs:
    let
      system = "x86_64-linux";

      extraArgs = {
        pkgs = import inputs.nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
      };

      defaultConfig = {
          inherit system;
          specialArgs = extraArgs;
          modules = [
            ./common/default.nix
            inputs.home-manager.nixosModules.home-manager
            { home-manager = { extraSpecialArgs = extraArgs; }; }
          ];
        };
    in
    {
      nixosConfigurations = {
        default = inputs.nixpkgs.lib.nixosSystem defaultConfig;
        java = inputs.nixpkgs.lib.nixosSystem (defaultConfig // {
          modules = defaultConfig.modules ++ [ ./env/java ];
        });
        c = inputs.nixpkgs.lib.nixosSystem (defaultConfig // {
          modules = defaultConfig.modules ++ [ ./env/c ];
        });
        petit-bain = inputs.nixpkgs.lib.nixosSystem (defaultConfig // {
          modules = defaultConfig.modules ++ [ ./env/petit-bain ];
        });
      };
    };
}
