{pkgs, ...}: let
  repo = pkgs.fetchFromGitHub {
    owner = "CodingClubBordeaux";
    repo = "petit-bain";
    rev = "5e6d79b663569aee700a09a2b21e3ba856ee4c60";
    hash = "sha256-YxDsaDYD9DXGjfzkTTrAxBQEkyqIQ5LfvBhQzRPkcW8=";
  };
in {
  imports = [
    ../c/config.nix
  ];

  home-manager.users.guest = {
    home.file."Desktop/guest/subjects".source = repo;
  };
}
