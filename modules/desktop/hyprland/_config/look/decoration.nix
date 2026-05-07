{}:

{
    decoration = {
        "rounding" = "0";
        "rounding_power" = "2";

        "active_opacity" = "1";
        "inactive_opacity" = "1";

        shadow = {
            "enabled" = "false";
            "range" = "4";
            "render_power" = "3";
            "color" = "rgba(1a1a1aee)";
        };

        blur = {
            "enabled" = "true";
            "size" = "1";
            "passes" = "4";

            "vibrancy" = "0.1696";
        };
    };

    windowrule = [
        "match:float 1, rounding 10"
    ];

    layerrule = [
        "ignore_alpha 0.1, match:namespace rofi"
        "blur on, match:namespace rofi"

        "ignore_alpha 0.1, match:namespace waybar"
        "blur on, match:namespace waybar"

        "ignore_alpha 0.1, match:namespace swaync-control-center"
        "blur on, match:namespace swaync-control-center"
    ];
}