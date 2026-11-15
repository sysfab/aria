{ self, lib, inputs, ... }:

{
    flake.os = {
        system ? "x86_64-linux",
        modules ? [],
        homeModules ? [],
        ...
    } @ args: inputs.nixpkgs.lib.nixosSystem (
        (removeAttrs args [ "homeModules" ]) // {
            inherit system;
            modules = modules ++ self.modules.system ++ [({ ... }: {
                hjem.extraModules = lib.mkAfter homeModules;
            })];
        }
    );
}
