{ pkgs, ... }:

{
  home.packages = with pkgs; [
    r2modman
    prismlauncher
  ];

  programs.obs-studio = {
    enable = true;
  };
}