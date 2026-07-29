options="Power\nChange wallpaper"

choice=$(printf "$options" | anyrun --plugins libstdin.so )

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
