{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aseprite
    (discord.override {
      withVencord = true;
    })
    #discord
    spotify
  ];
}
