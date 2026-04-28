{ pkgs, ... }:

pkgs.writeShellScriptBin "aria-update-wallpaper" ''

selected="$HOME/.aria/wallpaper.txt"
[ -f "$selected" ] || echo "$HOME/Pictures/Wallpapers/aria.png" > "$selected"

wallpaper=$(cat "$selected")
[ -f "$wallpaper" ] || { echo "$HOME/Pictures/Wallpapers/aria.png" > "$selected"; wallpaper="$HOME/Pictures/Wallpapers/aria.png"; }

# Check for --instant flag
instant_flag=""
if [ "$1" = "--instant" ]; then
  instant_flag="--transition none"
fi

awww img $instant_flag "$wallpaper"

''