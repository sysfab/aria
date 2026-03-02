{ pkgs, ... }:

pkgs.writeShellScriptBin "pick-wallpaper" ''

selected="$HOME/.aria/wallpaper.txt"
wallpapers="$HOME/Pictures/Wallpapers"

[ -d "$wallpapers" ] || exit 1

# List files in the directory
choice="$(printf "Random\n%s" "$(find "$wallpapers" -maxdepth 1 -type f -printf "%f\n")" | rofi -dmenu -p Wallpaper)" || exit
[ -z "$choice" ] && exit

# Pick a random wallpaper if "Random" is chosen
if [ "$choice" = "Random" ]; then
    choice="$(find "$wallpapers" -maxdepth 1 -type f -printf "%f\n" | shuf -n 1)"
    [ -z "$choice" ] && exit 1
fi

echo "$wallpapers/$choice" > "$selected"
update-wallpaper

''