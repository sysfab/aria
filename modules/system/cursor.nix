{ ... }:

let
    cursor_path = ../../extra/cursors/Moga-Cursor/Moga-Cursor;
    cursor_name = "Moga-Cursor";
in
{
    flake.nixosModules.cursor = { pkgs, ... }:
    let
        cursor = pkgs.stdenv.mkDerivation {
            pname = cursor_name;
            version = "latest";

            src = cursor_path;

            buildPhase = ''
                mkdir -p $out/share/icons/${cursor_name}
                cp -r * $out/share/icons/${cursor_name}
            '';
        };
    in
    {
        environment.systemPackages = [
            cursor
        ];
    };

    flake.homeModules.cursor = { ... }: {
        files.".icons/default".source = cursor_path;
    };
}
