{ pkgs, ... }:

{
    # login manager, TODO: need to do more research on this
    # sddm apparently works better, but boots me into nixos tty
    # lightdm boots properly but can't refresh hyprland without a reboot
    #services.xserver.displayManager.lightdm.enable = true;
    #services.xserver.displayManager.sddm.enable = true;
    # try librephoenix's:
    services.xserver.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "chili";
    };

    services.xserver.enable = true; # might need this for xwayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # tells electron apps to use wayland

    # hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
}