{ pkgs, ... }:

pkgs.writeShellScriptBin "update-wallpaper" ''

selected="$HOME/.aria/wallpaper.txt"
[ -f "$selected" ] || echo "$HOME/Pictures/Wallpapers/aria.png" > "$selected"

wallpaper=$(cat "$selected")
[ -f "$wallpaper" ] || { echo "$HOME/Pictures/Wallpapers/aria.png" > "$selected"; wallpaper="$HOME/Pictures/Wallpapers/aria.png"; }

swww img "$wallpaper"

'';