{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    steam-tui
    lutris
    r2modman
    (discord.override {
      withVencord = true;
    })
    spotify
    spotify-tui
  ];
}