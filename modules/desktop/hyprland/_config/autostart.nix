{}:

{
    exec-once = [
        "dbus-update-activation-environment --systemd --all"
        
        "swww-daemon"
        "update-wallpaper"

        "pkill waybar; waybar"
    ];
}