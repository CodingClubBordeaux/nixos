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
      cfg = {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
      pkgs = import inputs.nixpkgs cfg;
      extraArgs = {
        inherit pkgs;
      };
      defaultModules = [
        ./common/default.nix
        inputs.home-manager.nixosModules.home-manager
        { home-manager = { extraSpecialArgs = extraArgs; }; }
      ];
    in
    {
      nixosConfigurations = {
        "default" = inputs.nixpkgs.lib.nixosSystem {
          system = cfg.system;
          specialArgs = extraArgs;
          modules = defaultModules;
        };
        "java" = inputs.nixpkgs.lib.nixosSystem {
          system = cfg.system;
          specialArgs = extraArgs;
          modules = defaultModules ++ [
            ./env/java/default.nix
          ];
        };
      };
    };
}
