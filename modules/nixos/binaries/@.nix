{ ... }:

{
    flake.nixosModules.binaries = { pkgs, lib, ... }: let
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
        environment.systemPackages = generatedBins;
    };
}