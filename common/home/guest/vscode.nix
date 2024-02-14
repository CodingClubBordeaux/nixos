{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    programs.vscode.extensions = with pkgs.vscode-extensions; [
      usernamehw.errorlens
    ];

    userSettings = {
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
    };
  };
}
