#!/usr/bin/env bash

# init wallpaper daemon
swww init &
# set wallpaper image
swww img ~/Pictures/Wallpapers/bridget-guilty-gear-01.png &

#nm-applet --indicator &

# waybar
waybar &

#dunst
dunst &
