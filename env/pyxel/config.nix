{pkgs, ...}: {
  imports = [../python/config.nix];

  home-manager.users.guest.home = {
    packages = with pkgs.unstable; [
      pyxel
      sfml
      openal
      libvorbis
      flac
      SDL2
      SDL2_image
      libtiff
      libwebp
      SDL2_ttf
      pcre2.dev
      xdot
    ];
  };
}
