{ ... }:

{
    flake.nixosModules.quickshell = { pkgs, ... }:
    let
        reload = pkgs.writeShellScriptBin "aria-shell-reload" ''
            pkill quickshell; qs -p $XDG_CONFIG_HOME/aria-shell &
        '';

        ipc = pkgs.writeShellScriptBin "aria-shell" ''
            qs -p $XDG_CONFIG_HOME/aria-shell ipc call "$@"
        '';
    in
    {
        environment.systemPackages = with pkgs; [
            quickshell
            reload
            ipc

            kdePackages.qtdeclarative
        ];
    };

    flake.homeModules.quickshell = { ... }: {
        xdg.config.files = {
            "aria-shell".source = ./config;
        };
    };
}
