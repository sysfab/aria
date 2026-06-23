options="Change wallpaper\nPower"

choice=$(printf "$options" | rofi -dmenu -i -p "Picker")

case "$choice" in
    Power)
        aria-pick-power
        ;;
    "Change wallpaper")
        aria-pick-wallpaper
        ;;
    *)
        exit 1
        ;;
esac