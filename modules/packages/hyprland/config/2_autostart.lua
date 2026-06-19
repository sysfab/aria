start_cmd(
    "dbus-update-activation-environment --systemd --all",
    
    -- daemons
    "awww-daemon",

    "pkill swaync; swaync",
    "pkill waybar; waybar",

    "aria-update-wallpaper --instant"
)
