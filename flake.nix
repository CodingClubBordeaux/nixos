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

      defaultConfig = inputs.nixpkgs.lib.nixosSystem {
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
        "default" = defaultConfig;
        "java" = (defaultConfig // {
          modules = defaultConfig.modules ++ [ ./env/java ];
        });
      };
    };
}
