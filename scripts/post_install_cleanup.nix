{ pkgs, ... }:
{
  system.userActivationScripts = {
    text = ''
      echo "Running script"
      rm -rf /home/guest
      mkdir /home/guest
    '';
  };
}