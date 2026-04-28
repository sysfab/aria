{ ... }:

{
    layer = "top";
    position = "bottom";

    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    spacing = 0;

    height = 42;
    

    "clock" = {
        format = "{:%H:%M:%S}";
        format-alt = "{:%A, %B %d, %Y}";
        interval = 1;

        tooltip-format = "<tt><small>{calendar}</small></tt>";

        calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;

            format = {
                months = "<span color='#ffffff'><b>{}</b></span>";
                weekdays = "<span color='#bbbbbb'><b>{}</b></span>";

                days = "<span color='#a0a0a0'><b>{}</b></span>";
                today = "<span color='#ffffff'><b>{}</b></span>";
            };
        };

        actions = {
            "on-click-right" = "mode";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
        };
    };

    "tray" = {
        spacing = 10;
        show-passive-items = true;
    };

    "custom/notification" = {
        tooltip = false;
        format = "{icon}";

        format-icons = {
            notification = "<span></span>";
            none = "<span></span>";
            dnd-notification = "<span></span>";
            dnd-none = "<span></span>";
        };

        return-type = "json";

        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d";

        escape = true;
    };

    modules-left = [
        "tray"
    ];

    modules-center = [
        "clock"
    ];

    modules-right = [
        "custom/notification"
    ];
}