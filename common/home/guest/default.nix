{ pkgs, ... }:
let
  username = "guest";
in
{
  imports = [
    ./vscode.nix
  ];
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";

    packages = with pkgs; [
      neofetch
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/background" = {
      "picture-uri" = "file://" + ../../../assets/wallpaper.jpg;
    };
    "org/gnome/desktop/screensaver" = {
      "picture-uri" = "file://" + ../../../assets/wallpaper.jpg;
    };
  };
}
