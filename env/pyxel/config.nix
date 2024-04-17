{pkgs, ...}: {
  imports = [../python/config.nix];

  home-manager.users.guest.home = {
    packages = with pkgs; [unstable.pyxel];

    activation.createRepository = "${pkgs.writeShellScript "createRepository" ''
      # Check is $HOME/.repo.bak exists
      if [ -d $HOME/.repo.bak ]; then
        rm -rf $HOME/.repo.bak
      fi

      # Check is $HOME/Desktop/guest exists
      if [ -d $HOME/Desktop/guest ]; then
        mv $HOME/Desktop/guest $HOME/.repo.bak
      fi

      mkdir -p $HOME/Desktop/guest
      cd $HOME/Desktop/guest

      cat <<EOF > main.py
      import pyxel  # On importe la bibliothèque Pyxel

      # Fonction pour mettre à jour l'état du jeu
      def update():
          # Quitter le jeu lorsque l'on clique sur Q
          if pyxel.btn(pyxel.KEY_Q):
            pyxel.quit()

      # Fonction pour dessiner le jeu à l'écran
      def draw():
        pyxel.cls(0) # Efface la fenêtre de jeu et la remplit de noir

      pyxel.init(120, 160, title="Tek Shooter")  # On initialise la fenêtre avec une taille de 120x160 pixels
      pyxel.run(update, draw)  # On lance la boucle principale du jeu
      EOF
    ''}";
  };
}
