{
  pkgs,
  gnomeExtensions,
  ...
}: let
  username = "guest";

  rebuild = pkgs.writeShellScriptBin "rebuild" ''
    exec sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch          \
      --impure                                                        \
      --refresh                                                       \
      --flake github:CodingClubBordeaux/nixos#${"\${1:-\"default\"}"}
  '';
in {
  imports = [
    ./vscode.nix
    ./zsh.nix
    ./minecraft.nix
    ./firefox.nix
  ];
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    sessionVariables.LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [pkgs.SDL2]}";

    stateVersion = "23.11";

    packages =
      [rebuild]
      ++ (with pkgs; [
        # softs
        neofetch
        libreoffice
        arduino
        tic-80
        lua

        # c dev tools
        gcc13
        gnumake
        gcovr
        ltrace
        valgrind
        python311Packages.compiledb
        python311Packages.pygame
        gdb
        glibc

        # java
        zulu8
        maven

        # clang tools
        clang-analyzer
        clang-tools_17

        # dev
        rustup
        nodejs_22
        corepack_22
        typescript
        deno

        # python
        python311
        python311.pkgs.pillow
        python311.pkgs.pygame
        nodePackages.pyright

        # man pages
        man-pages
        man-pages-posix
        stdman
        linux-manual

        SDL2
	google-chrome
      ]);
  };

  dconf.settings = {
    "org/gnome/desktop/background" = {
      "picture-uri" = "file://" + ../../../assets/wallpaper.jpg;
    };
    "org/gnome/desktop/screensaver" = {
      "picture-uri" = "file://" + ../../../assets/wallpaper.jpg;
    };
    "org.gnome.desktop.peripherals.touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      enabled-extensions = map (e: e.extensionUuid) gnomeExtensions;
    };
  };
}
