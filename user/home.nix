{ config, pkgs, pkgs-stable, lib, stylix, settings, ... }:

{
  imports = [
    ./modules/core.nix
    ./modules/development.nix
    ./modules/gaming.nix
    ./modules/hyprland.nix
    ./modules/sh.nix
    ./modules/stylix.nix
  ];

  # allow unfree + insecure
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  # user to manage (me! :D)
  home.username = "stormytuna";
  home.homeDirectory = "/home/stormytuna";

  # dotfiles
  home.file = {
    ".config/hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
    ".config/hypr/wallpaper.png".source = ./theming/wallpapers/${settings.wallpaper}.png;
    ".config/waybar/config.jsonc".source = ./configs/waybar/config.jsonc;
    ".config/waybar/modules.jsonc".source = ./configs/waybar/modules.jsonc;
    ".config/nixpkgs/config.nix".source = ./configs/nixpkgs/config.nix;
    ".config/fish/functions/fish_prompt.fish".source = ./configs/fish/fish_prompt.fish;
    ".config/swaync/config.json".source = ./configs/swaync/config.json;
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
