{ ... }:

{
    flake.homeModules.zed = { ... }: {
        xdg.config.files."zed/settings.json".source = ./settings.json;
    };
}
