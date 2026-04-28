{ pkgs, ... }:

pkgs.writeShellScriptBin "aria-picker" ''

options="Change wallpaper\nPower"

choice=$(printf "$options" | rofi -dmenu -i -p "Picker")

case "$choice" in
    "Change wallpaper")
        aria-pick-wallpaper
        ;;
    Power)
        aria-pick-power
        ;;
    *)
        exit 1
        ;;
esac

''