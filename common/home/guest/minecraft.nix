{pkgs, ...}: {
  home.packages = [
    # Prism but with java 21
    (pkgs.prismlauncher.override { jdks = [ pkgs.temurin-bin-21 pkgs.temurin-bin-8 pkgs.temurin-bin-17 ]; })
  ];

  # Add a offline account to prism
  #          .local/share/PrismLauncher/accounts.json
  # home.file.".local/share/PrismLaucher/accounts.json".text = ''
  xdg.dataFile."PrismLauncher/accounts.json".text = ''
    {
      "formatVersion": 3,
      "accounts": [{
        "active": true,
        "entitlement": {
          "canPlayMinecraft": true,
          "ownsMinecraft": true
        },
        "profile": {
          "capes": [],
          "id": "8e28915920343a1696b99fa637848b3b",
          "name": "BobTheBuilder",
          "skin": {
            "id": "",
            "url": "",
            "variant": ""
          }
        },
        "type": "Offline",
        "ygg": {
          "extra": {
            "clientToken": "b869365f75484c75b09497e8599e5ab3",
            "userName": "BobTheBuilder"
          },
          "iat": 1714175080,
          "token": "0"
        }
      }]
    }
  '';
}
