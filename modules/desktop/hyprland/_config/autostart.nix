{}:

{
    exec-once = [
        "dbus-update-activation-environment --systemd --all"
        
        "awww-daemon"
        "update-wallpaper --instant"

        "pkill waybar; waybar"
    ];
}