{ pkgs, ... }:

{
    flake.homeModules.kitty = {
        programs.kitty = {
            enable = true;

            settings = {
                enable_audio_bell = false;
                confirm_os_window_close = 0;
            };

            extraConfig = "
                cursor_trail 3
                cursor_trail_start_threshold 1
                cursor_trail_decay 0.1 0.4
            ";
        };
    };
}