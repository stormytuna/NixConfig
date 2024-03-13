{ config, stylix, ... }:

let
    curTheme = "bridget";
in
{
    stylix = {
        image = ../themes/${curTheme}/wallpaper.png;
        base16Scheme = ../themes/${curTheme}/scheme.yaml;
        polarity = "dark";
        opacity = {
            terminal = 0.90;
            applications = 0.90;
            popups = 0.50;
            desktop = 0.90;
        };
    };
}