{ pkgs, ... }:
let
  username = "guest";
in
{
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";

    packages = with pkgs; [
      vscode
    ];
  };
}