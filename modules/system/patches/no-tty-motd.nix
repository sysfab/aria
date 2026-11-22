{ ... }:

{
    flake.nixosModules.no-tty-motd = { ... }: {
        environment.etc."issue".text = "";
        services.getty.helpLine = "";
        environment.etc."motd".text = "";
    };
}
