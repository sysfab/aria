start_cmd(
    "dbus-update-activation-environment --systemd --all",
    
    -- daemons
    "awww-daemon",
    "pkill swaync; swaync",

    "aria-update-wallpaper --instant",
    "pkill waybar; waybar"
)