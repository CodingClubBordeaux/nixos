{ pkgs, ... }:
let
  VSkript = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vskript";
      publisher = "Vhone";
      version = "0.0.8";
      sha256 = "sha256-LV+3B5PnPSfhL8Ii7k+tuuV3vVzdqnk6PRic9NL/TUw=";
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    zulu8
    maven
  ];

  home-manager.users.guest = {
    programs.vscode.extensions = [
      VSkript
    ];
  };
}
