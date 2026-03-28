{ pkgs, ... }:

pkgs.writeShellScriptBin "pick-power" ''

options="Shutdown\nReboot\nLogout"

choice=$(printf "$options" | rofi -dmenu -i -p "Power")

case "$choice" in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Logout)
        loginctl terminate-user "$USER"
        ;;
    *)
        exit 1
        ;;
esac

''