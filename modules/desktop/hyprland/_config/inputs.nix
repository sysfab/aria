{}:

{
    input = {
        "kb_layout" = "us, ua";
        "kb_variant" = "";
        "kb_model" = "";
        "kb_options" = "caps:none,grp:alt_shift_toggle";
        "kb_rules" = "";

        "follow_mouse" = "1";
        "sensitivity" = "-0.5";
    };

    bind = [
        "SUPER, Q, exec, kitty"
        "SUPER, E, exec, nautilus"

        "SUPER, R, exec, pkill rofi || rofi -show drun"
        "SUPER SHIFT, R, exec, pick-wallpaper"

        "SUPER, C, killactive,"
        "SUPER, V, togglefloating,"

        "SUPER, A, layoutmsg togglesplit"
        "SUPER, D, layoutmsg swapsplit"

        ", PRINT, exec, hyprshot -m region --freeze"
        "SHIFT, PRINT, exec, hyprshot -m output --freeze"
        "SUPER, PRINT, exec, hyprshot -m window --freeze"

        "SUPER SHIFT, B, exec, pkill waybar; waybar"

        "SUPER, left, movewindow, l"
        "SUPER, right, movewindow, r"
        "SUPER, up, fullscreen, 1"
        "SUPER, down, fullscreen, 2"

        "SUPER SHIFT, right, movecurrentworkspacetomonitor, +1"
        "SUPER SHIFT, left, movecurrentworkspacetomonitor, -1"
    
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
    ];

    bindm = [          
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
    ];
}
