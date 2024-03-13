{ config, pkgs, lib, stylix, ... }:

let
  curWallpaper = "bridget";
in
{
  imports = [
    ./modules/core.nix
    ./modules/development.nix
    ./modules/gaming.nix
    ./modules/hyprland.nix
    ./modules/sh.nix
    ./modules/stylix.nix
  ];

  # allow unfree
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # user to manage (me! :D)
  home.username = "stormytuna";
  home.homeDirectory = "/home/stormytuna";

  # dotfiles
  home.file = {
    ".config/hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
    ".config/hypr/start.sh".source = ./configs/hypr/start.sh;
    ".config/hypr/wallpaper.png".source = ./themes/${curWallpaper}/wallpaper.png;
    ".config/waybar/config.jsonc".source = ./configs/waybar/config.jsonc;
    ".config/waybar/modules.jsonc".source = ./configs/waybar/modules.jsonc;
    ".config/waybar/style.css".source = ./configs/waybar/style.css;
    ".config/nixpkgs/config.nix".source = ./configs/nixpkgs/config.nix;
    ".config/fish/functions/fish_prompt.fish".source = ./configs/fish/fish_prompt.fish;
  };

  # env vars
  home.sessionVariables = {
    
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
