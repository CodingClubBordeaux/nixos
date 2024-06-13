{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    initExtra = ''
      COMPLETION_WAITING_DOTS="true"
      HIST_STAMPS="mm/dd/yyyy"

      export PATH="$HOME/.local/bin:$PATH"
    '';
    plugins = [
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "F-Sy-H";
        src = pkgs.zsh-f-sy-h;
        file = "share/zsh/site-functions/F-Sy-H.plugin.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "direnv"
        "colored-man-pages"
        "copyfile"
      ];
    };
  };
}
