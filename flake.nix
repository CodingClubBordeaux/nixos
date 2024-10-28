{
  description = "NixOS Coding Club Bordeaux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs_unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: let
    cfg = {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    pkgs = import inputs.nixpkgs (
      cfg // {overlays = [(_: _: {unstable = import inputs.nixpkgs_unstable cfg;})];}
    );

    extraArgs = {
      inherit pkgs;
      gnomeExtensions = with pkgs.gnomeExtensions; [
        blur-my-shell
        tiling-assistant
        caffeine
        desktop-icons-ng-ding
      ];
    };

    inherit (inputs.nixpkgs) lib;
  in {
    formatter.${cfg.system} = extraArgs.pkgs.alejandra;

    nixosConfigurations = rec {
      default = nixos;
      nixos = lib.nixosSystem {
        inherit (cfg) system;
        specialArgs = extraArgs;
        modules = [
          ./config/default.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = extraArgs;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
