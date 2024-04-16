{pkgs, ...}: let
  repo = pkgs.fetchFromGitHub {
    owner = "CodingClubBordeaux";
    repo = "epitech-clicker";
    rev = "89cfbaa8f9a7e500cb06d406ef48d6de63d53648";
    hash = "sha256-nUR4QgrJt/haEd6YfUzo8WyS6P4kmTATaj2R8tS7jVE=";
  };
in {
  home-manager.users.guest = {
    home.packages = with pkgs; [
      # maybe useful
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
    ];

    programs.vscode.extensions = with pkgs.vscode-extensions; [
      ritwickdey.liveserver
      ms-vscode.live-server
      gencer.html-slim-scss-css-class-completion
    ];

    home.file."Desktop/guest/subjects".source = repo;
  };
}
