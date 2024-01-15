{
  description = "NixOS Coding Club Bordeaux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, ...} @ inputs: 
    let
      cfg = {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
      pkgs = import inputs.nixpkgs cfg;
    in
    {
      formatter.${cfg.system} = pkgs.nixpkgs-fmt;

      nixosConfigurations = {
        "default" = nixpkgs.lib.nixosSystem {
          system = cfg.system;
          specialArgs = inputs;
          modules = [
            ./common/default.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };
        "java" = nixpkgs.lib.nixosSystem {
          system = cfg.system;
          specialArgs = inputs;
          modules = [
            ./common/default.nix
            ./env/java/default.nix
          ];
        };
      };
    };
}
