{ pkgs, ... }:

pkgs.writeShellScriptBin "aria-pick-wallpaper" ''

selected="$HOME/.aria/wallpaper.txt"
wallpapers="$HOME/Pictures/Wallpapers"

[ -d "$wallpapers" ] || exit 1

choice="$(
{
    echo "Random wallpaper"
    find -L "$wallpapers" -maxdepth 1 -type f -printf "%f\n"
} | rofi -dmenu -p Wallpaper
)" || exit

[ -z "$choice" ] && exit

if [ "$choice" = "Random" ]; then
    choice="$(find -L "$wallpapers" -maxdepth 1 -type f -printf "%f\n" | shuf -n 1)"
    [ -z "$choice" ] && exit 1
fi

echo "$wallpapers/$choice" > "$selected"
aria-update-wallpaper

''