{ pkgs, ... }:

{
  # Packages I'd want on any system
  environment.systemPackages = with pkgs; [
    vim
    tldr
    git
    gh
    firefox # TODO: Investigate alternatives, librefox, qutebrowser
    bitwarden
    pavucontrol
    vulkan-tools
  ];
}