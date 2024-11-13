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
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    extensions =
      (with pkgs.vscode-extensions; [
        usernamehw.errorlens

        # c/c++
        llvm-vs-code-extensions.vscode-clangd
        vadimcn.vscode-lldb

        # python
        ms-python.python
        ms-python.vscode-pylance
        ms-python.isort
        ms-python.debugpy
        ms-python.black-formatter

        # web
        ritwickdey.liveserver
        ms-vscode.live-server
        gencer.html-slim-scss-css-class-completion
      ])
      ++ [ VSkript ];

    userSettings = {
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
    };
  };

  home.packages = with pkgs; [
    # maybe useful
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
  ];
}
