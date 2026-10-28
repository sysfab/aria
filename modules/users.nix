{ self, ... }:

{
    flake.nixosModules.users = { pkgs, lib, config, options, ... }:
    let
        inherit (lib) mkOption types;

        nativeUserOptions =
            options.users.users.type.nestedTypes.elemType.getSubOptions [];

        ariaUserType = types.submodule ({ name, ... }: {
            options =
                (removeAttrs nativeUserOptions [
                    "_module"
                    "isNormalUser"
                ]) // {
                    enable = mkOption {
                        type = lib.types.bool;
                        default = true;
                    };

                    modules = mkOption {
                        type = types.listOf types.deferredModule;
                        default = [];
                        description = "Hjem modules for this user";
                    };
                };

            config = {
                name = lib.mkDefault name;
                group = lib.mkDefault "users";
                home = lib.mkDefault "/home/${name}";
                createHome = lib.mkDefault true;
                useDefaultShell = lib.mkDefault true;

                shell = lib.mkDefault pkgs.zsh;
            };
        });

        cfg = config.aria.users;
        enabledUsers = lib.filterAttrs (_: user: user.enable) cfg;
    in
    {
        options.aria.users = mkOption {
            type = types.attrsOf ariaUserType;
            default = {};
            description = "Aria user configuration";
        };

        config = {
            users.users = lib.mapAttrs (
                name: user:
                    (removeAttrs user [
                        "enable"
                        "modules"
                    ]) // {
                        isNormalUser = true;
                    }
            ) enabledUsers;

            hjem.users = lib.mapAttrs (
                name: user: {
                    enable = true;
                    imports = self.modules.home ++ user.modules;
                }
            ) enabledUsers;
        };
    };
}
