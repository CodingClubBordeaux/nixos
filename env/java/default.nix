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
  home-manager.users.guest = {
    home.packages = with pkgs; [
      zulu8
      maven
    ];

    programs.vscode.extensions = [
      VSkript
    ];
  };
}
