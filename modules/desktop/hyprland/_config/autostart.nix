{}:

{
    exec-once = [
        "dbus-update-activation-environment --systemd --all"
        
        "awww-daemon"
        "update-wallpaper"

        "pkill waybar; waybar"
    ];
}