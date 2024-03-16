{ pkgs, ... }:
{
  home-manager.users.guest = {
    home.packages = with pkgs; [
      python311
      python311.pkgs.pip
      python311.pkgs.venv
      python311.pkgs.pillow
      python311.pkgs.pygame

      nodePackages.pyright
    ];

    programs.vscode.extensions = with pkgs.vscode-extensions; [
      ms-pyright.pyright
    ];
  };
}
