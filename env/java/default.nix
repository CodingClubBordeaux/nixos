{ config, pkgs, ... }:
 
{
  environment.systemPackages = with pkgs; [
    zulu8
    maven
  ];
}