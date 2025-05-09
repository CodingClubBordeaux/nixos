{
  pkgs,
  gnomeExtensions,
  ...
}: {
  imports = [
    "/etc/nixos/hardware-configuration.nix"
  ];

  home-manager.users.guest = import ./home/guest;
  home-manager.useGlobalPkgs = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

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

  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  # https://wiki.nixos.org/wiki/GNOME#Automatic_login
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "guest";
    };
    defaultSession = "gnome";
  };

  services.xserver = {
    xkb = {
      layout = "fr";
      variant = "";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.gnome.excludePackages = [pkgs.gnome-tour];

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

  users = {
    users = {
      root.password = "Epitech1!";

      guest = {
        createHome = true;
        isNormalUser = true;
        initialPassword = "";
        description = "Coding Club Guest";
        shell = pkgs.zsh;
        extraGroups = ["networkmanager" "wheel"];
      };
    };

    mutableUsers = false;
  };
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      vim
      git
      tree
      wget
      curl
    ])
    ++ gnomeExtensions;

  virtualisation.vmVariant.virtualisation = {
    memorySize = 4096; # MiB RAM
    cores = 4; # CPU cores
  };

  nix.settings.trusted-users = [ "@wheel" ]; # rebuild over ssh

  security.sudo = {
    extraConfig = ''
      Defaults targetpw
    '';
  };

  networking.firewall.allowedUDPPorts = [6969];
  networking.firewall.allowedTCPPorts = [6969];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
