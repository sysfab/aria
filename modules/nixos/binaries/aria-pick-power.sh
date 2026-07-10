options="Shutdown\nReboot\nLogout"

choice=$(printf "$options" | walker --dmenu -p "Power")

case "$choice" in
    Shutdown)
        hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'
        ;;
    Reboot)
        hyprshutdown -t 'Restarting...' --post-cmd 'reboot'
        ;;
    Logout)
        hyprshutdown -t 'Loggining off...'
        ;;
    *)
        exit 1
        ;;
esac
