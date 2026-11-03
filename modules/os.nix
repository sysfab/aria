{ self, inputs, ... }:

{
    flake.os = {
        system ? "x86_64-linux",
        modules ? [],
        homeModules ? [],
        ...
    } @ args: inputs.nixpkgs.lib.nixosSystem (
        args // {
            inherit system;
            modules = modules ++ self.modules.system ++ [({ ... }: {
                hjem.extraModules = homeModules;
            })];
        }
    );
}
