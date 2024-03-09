{ pkgs, ... }:

{
  # Packages I'd want on any system
  environment.systemPackages = with pkgs; [
    vim
    grc # fish shell colourisation, even though we don't have fish here we can't install it using 
    tldr
    git
    gh
    #xfce.thunar # TODO: Alternative? since i wanna use hyprland not xfce?
    firefox
    bitwarden
  ];
}