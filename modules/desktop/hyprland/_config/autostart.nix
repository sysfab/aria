{}:

{
    exec-once = [
        "dbus-update-activation-environment --systemd --all"
        
        "awww-daemon"
        "aria-update-wallpaper --instant"

        "pkill waybar; waybar"
    ];
}