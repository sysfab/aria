{ ... }:

{
    flake.nixosModules.wayland-envs = { ... }: {
        environment.variables = {
            NIXOS_OZONE_WL = "1";
            ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
        };
    };
}
