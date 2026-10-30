{ self, ... }:

let
    folder = "Pictures/Wallpapers";

    selected = "${folder}/.selected.txt";
    default = "${folder}/.default.png";
in
{
    flake.nixosModules.wallpapers = { config, pkgs, ... }:
    let
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

            awww img $transition "$wallpaper"
        '';

        aria-pick-wallpaper = pkgs.writeShellScriptBin "aria-pick-wallpaper" ''
            wallpapers="$HOME/Pictures/Wallpapers"
            selected="$wallpapers/.selected.txt"

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

            printf '%s\n' "''${files[index]}" > "$selected"
            aria-wallpaper-update
        '';
    in
    {
        aria.pickers.wallpapers = {
            name = "Change wallpapers";
            command = "aria-pick-wallpaper";
        };

        environment.systemPackages = [
            pkgs.awww
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
