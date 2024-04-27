{pkgs, ...}: let
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
  ];
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";

    packages =
      [
        rebuild
      ]
      ++ (with pkgs; [
        neofetch
        firefox
      ])
      ++ (with pkgs.gnomeExtensions; [
        desktop-icons-ng-ding
      ]);
  };

  dconf.settings = {
    "org/gnome/desktop/background" = {
      "picture-uri" = "file://" + ../../../assets/wallpaper.jpg;
    };
    "org/gnome/desktop/screensaver" = {
      "picture-uri" = "file://" + ../../../assets/wallpaper.jpg;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      enabled-extensions = [
        "ding@rastersoft.com" # desktop-icons-ng-ding
      ];
    };
  };
}
