{
  description = "NixOS Coding Club Bordeaux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: let
    system = "x86_64-linux";

    extraArgs = {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
      };
    };

    defaultConfig = {
      inherit system;
      specialArgs = extraArgs;
      modules = [
        ./common/default.nix
        inputs.home-manager.nixosModules.home-manager
        {home-manager = {extraSpecialArgs = extraArgs;};}
      ];
    };

    inherit (inputs.nixpkgs) lib;

    directories = let
      containsConfig = dir: builtins.hasAttr "config.nix" (builtins.readDir ./env/${dir});
      isConfig = name: type: type == "directory" && containsConfig name;
    in
      builtins.attrNames (lib.filterAttrs isConfig (builtins.readDir ./env));
  in {
    formatter.${system} = extraArgs.pkgs.alejandra;

    nixosConfigurations =
      {
        default = lib.nixosSystem defaultConfig;
      }
      # All the directories in ./env are automatically turned into independants
      # NixOS configurations
      // builtins.listToAttrs (builtins.map (dir: {
          name = dir;
          value = lib.nixosSystem (defaultConfig
            // {
              modules = defaultConfig.modules ++ [./env/${dir}/config.nix];
            });
        })
        directories);
  };
}
