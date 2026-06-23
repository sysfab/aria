{ pkgs, ... }:

{
    flake.homeModules.zed = { ... }: {
        xdg.config.files."zed/settings.json".source = ./setting.json;
    };
}
