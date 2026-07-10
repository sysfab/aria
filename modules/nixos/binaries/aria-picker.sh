options="Power\nChange wallpaper"

choice=$(printf "$options" | walker --dmenu -p "Picker")

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
