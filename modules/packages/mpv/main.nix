{ ... }:

{
    flake.nixosModules.mpv = { pkgs, ... }: {
        aria.scripts.mpv-clipboard = ''
            url=$(wl-paste --no-newline)

            case "$url" in
                http://*|https://*|\
                ftp://*|ftps://*|sftp://*|\
                rtsp://*|rtsps://*|\
                rtmp://*|rtmps://*|rtmpt://*|rtmpts://*|\
                rtp://*|srtp://*|\
                tcp://*|udp://*|\
                mms://*|mmst://*|mmsh://*|\
                srt://*|rist://*|\
                smb://*|file://*|\
                ytdl://*|mpv://*)
                    ;;
                *)
                    if [[ ! -f "$url" ]]; then
                        echo "Clipboard does not contain a supported URL or existing file." >&2
                        exit 1
                    fi
                    ;;
            esac

            printf "Playing '%s'...\n" "$url"
            exec mpv --really-quiet --no-terminal "$url" "$@" & disown
        '';

        environment.systemPackages = with pkgs; [
            (mpv.override {
                scripts = with pkgs.mpvScripts; [
                    uosc
                    thumbfast

                    visualizer

                    sponsorblock
                    quality-menu
                ];
            })

            ffmpeg
            yt-dlp
            wl-clipboard
        ];
    };

    flake.homeModules.mpv = { ... }: {
        xdg.config.files = {
            "mpv/mpv.conf".source = ./mpv.conf;

            "mpv/script-opts/uosc.conf".source = ./scripts/uosc.conf;
            "mpv/script-opts/visualizer.conf".source = ./scripts/visualizer.conf;
        };
    };
}
