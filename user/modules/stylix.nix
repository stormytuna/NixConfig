{ config, stylix, pkgs, settings, ... }:

{
    stylix = {
        image = ../theming/wallpapers/${settings.wallpaper}.png;
        base16Scheme = ../theming/colour-schemes/${settings.colourScheme}.yaml;
        polarity = "${settings.polarity}";
        cursor = {
            package = pkgs.bibata-cursors;
            name = "Bibata Original Classic";
            size = 22;
        };
        #fonts = {
        #    serif = {
        #        package = pkgs.nerdfonts;
        #        name = "FiraCode Nerd Font Mono";
        #    };
        #    sansSerif = {
        #        package = pkgs.nerdfonts;
        #        name = "FiraCode Nerd Font Mono";
        #    };
        #    monospace = {
        #        package = pkgs.nerdfonts;
        #        name = "FiraCode Nerd Font Mono";
        #    };
        #    sizes = {
        #        desktop = 12;
        #        applications = 12;
        #        terminal = 12;
        #        popups = 12;
        #    };
        #};
    };
}