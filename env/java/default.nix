{ config, pkgs, ... }:
 
{
  environment.systemPackages = with pkgs; [
    javac
    maven
  ];
}