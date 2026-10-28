{ ... }:

{
    flake.nixosModules.bins = { config, lib, pkgs, ... }: let
        entries = builtins.readDir ./.;

        shFiles = lib.filterAttrs (
            name: type:
            type == "regular" && lib.hasSuffix ".sh" name
        ) entries;

        mkScript = name: _:
        let
            scriptName = lib.removeSuffix ".sh" name;
            content = builtins.readFile (./. + "/${name}");
        in
        pkgs.writeShellScriptBin scriptName content;

        generatedBins = lib.mapAttrsToList mkScript shFiles;
    in
    {
        options.aria.scripts.enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
        };

        config = lib.mkIf config.aria.scripts.enable {
            environment.systemPackages = generatedBins;
        };
    };
}
