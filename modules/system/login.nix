{ ... }:

{
    flake.nixosModules.login = { pkgs, ... }: {
        services.greetd = {
            enable = true;
            restart = false;

            settings = {
                default_session = {
                    command = "${pkgs.tuigreet}/bin/tuigreet";
                    user = "greeter";
                };
            };
        };

        environment.etc."tuigreet/config.toml".text = ''
            [display]
            issue = false
            show_time = false
            greeting = "Welcome!"

            [layout]
            width = 48

            [layout.widgets]
            status_position = "bottom"

            [layout.widgets.status_bar]
            show_reset = false
            show_command = false
            show_session = true
            show_power = true
            show_background = false
            show_session_status = false
            show_caps_lock = true

            [secret]
            mode = "characters"
            characters = "*"

            [remember]
            username = true

            [background]
            kind = "none"
        '';
    };
}
