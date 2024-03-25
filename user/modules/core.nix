{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    blueman
    aseprite
    vesktop
    #(discord.override {
    #  withVencord = true;
    #})
    #discord
    config.nur.repos.nltch.spotify-adblock
    #spotify
    premid
    unetbootin
  ];

  services.blueman-applet.enable = true;
}
