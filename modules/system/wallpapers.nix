{ ... }:

let
    folder = "Pictures/Wallpapers";

    selected = "${folder}/.selected.txt";
    default = "${folder}/.default.png";
in
{
    flake.nixosModules.wallpapers = { config, pkgs, ... }:
    let
        aria-wallpaper-set = pkgs.writeShellScriptBin "aria-wallpaper-set" ''
            wallpapers="$HOME/${folder}"
            selected="$HOME/${selected}"

            [[ -n "$1" ]] || exit 1

            wallpaper="$wallpapers/$1"
            [[ -f "$wallpaper" ]] || {
                echo "Wallpaper not found: $1" >&2
                exit 1
            }

            printf '%s\n' "$wallpaper" > "$selected"
            aria-wallpaper-update
        '';

        aria-wallpaper-update = pkgs.writeShellScriptBin "aria-wallpaper-update" ''
            selected="$HOME/${selected}"
            default="$HOME/${default}"

            [ -f "$selected" ] || {
                echo "$default" > "$selected"
            }

            wallpaper=$(cat "$selected")
            [ -f "$wallpaper" ] || {
                echo "$default" > "$selected";
                wallpaper="$default";
            }

            transition=""
            if [ "$1" = "--instant" ]; then
                transition="--transition-type none"
            else
                transition="--transition-type grow --transition-pos bottom --transition-duration 2 --transition-fps 144"
            fi

            if ! pgrep -f '[/]bin/awww-daemon' > /dev/null; then
                nohup awww-daemon > /dev/null 2>&1 &
                for i in $(seq 1 10); do
                    awww query > /dev/null 2>&1 && break
                    sleep 0.1
                done
            fi
            awww img $transition "$wallpaper"
        '';

        aria-pick-wallpaper = pkgs.writeShellScriptBin "aria-pick-wallpaper" ''
            wallpapers="$HOME/Pictures/Wallpapers"
            [[ -d "$wallpapers" ]] || exit 1

            files=()
            names=()

            for file in "$wallpapers"/*; do
                [[ -f "$file" ]] || continue

                name="''${file##*/}"
                [[ "$name" == .* ]] && continue

                files+=("$file")
                names+=("''${name%.*}")
            done

            ((''${#files[@]})) || exit 1

            choice="$(
                printf '%s\n' "Random wallpaper" "''${names[@]}" | ${config.aria.picker.handler}
            )" || exit 1

            [[ -n "$choice" ]] || exit

            if [[ "$choice" == "Random wallpaper" ]]; then
                index="$(shuf -i 0-$((''${#files[@]} - 1)) -n 1)"
            else
                for index in "''${!names[@]}"; do
                    [[ "''${names[index]}" == "$choice" ]] && break
                done

                [[ "$index" -lt "''${#files[@]}" ]] || exit 1
            fi

            aria-wallpaper-set "''${files[index]##*/}"
        '';
    in
    {
        aria.pickers.wallpaper = {
            name = "Change wallpapers";
            command = "aria-pick-wallpaper";
        };

        environment.systemPackages = [
            pkgs.awww
            aria-wallpaper-set
            aria-wallpaper-update
            aria-pick-wallpaper
        ];
    };

    flake.homeModules.wallpapers = { ... }: {
        files = {
            "${default}".source = ../../media/background.png;
        };
    };
}
