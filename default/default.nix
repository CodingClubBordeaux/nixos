{ config, pkgs, ... }:
 
{
  imports =
    [
      ../hardware-configuration.nix
    ];
 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 
  networking.hostName = "nixos";
  networking.wireless.enable = true;
 
  networking.networkmanager.enable = true;
 
  time.timeZone = "Europe/Paris";
 
  i18n.defaultLocale = "en_US.UTF-8";
 
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver.enable = true;
 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
 
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };
 
  console.keyMap = "fr";
 
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
 
  users.users.guest = {
    isNormalUser = true;
    initialPassword = "Epitech1!";
    description = "Coding Club Guest";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };
 
  nixpkgs.config.allowUnfree = true;
 
  environment.systemPackages = with pkgs; [
    vim
    git
    tree
    wget
    curl
    neofetch
  ];
 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}