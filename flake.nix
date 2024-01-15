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
      };
    in
    {
      nixosConfigurations = {
        "default" = nixpkgs.lib.nixosSystem {
          system = cfg.system;
          specialArgs = inputs;
          modules = [
            ./common/default.nix
            inputs.home-manager.nixosModules.home-manager
            { home-manager = specialArgs; }
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
