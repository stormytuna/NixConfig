#!/usr/bin/env bash

# init wallpaper daemon
swww init &
# set wallpaper image
swww img ~/.config/hypr/wallpaper.png &

# waybar
waybar &

# dunst
dunst &

# discord
discord &