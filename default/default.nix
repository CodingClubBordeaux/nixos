{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    neofetch
    gcc
  ];

  home-manager.users.guest = {
    home.stateVersion = "23.11";
  }

  users.users.guest = {
    isNormalUser = true;
    description = "Coding Club Guest"
    initialPassword = "Epitech1!";
    extraGroups = [ "wheel" ];
    createHome = true;
    packages = with pkgs; [];
  }

  time.timeZone = "Europe/Paris";

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.11";
}