{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    #alacritty # TODO: wanna test this out after getting themes setup
    (waybar.overrideAttrs ( # override lets it work with workspaces properly
      oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }
    ))
    dunst
    libnotify
    swww
    rofi-wayland
    grim
    slurp
    wl-clipboard
    # TODO: Get screen sharing working
    pipewire
    wireplumber
  ];
}