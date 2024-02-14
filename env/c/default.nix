{ pkgs, ... }:
{
  home-manager.users.guest = {
    home.packages = with pkgs; [
      # c dev tools
      gcc13
      gnumake
      gcovr
      ltrace
      valgrind
      python311Packages.compiledb
      gdb
      glibc

      # clang tools
      clang-analyzer
      clang-tools_17

      # man pages
      man-pages
      man-pages-posix
      stdman
      linux-manual
    ];

    programs.vscode.extensions = with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.vscode-clangd
      usernamehw.errorlens
      vadimcn.vscode-lldb
    ];
  };
}
