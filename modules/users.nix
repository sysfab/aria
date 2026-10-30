{ self, ... }:

{
    flake.nixosModules.users = { lib, config, options, pkgs, ... }:
    let
        nativeUserOptions =
            options.users.users.type.nestedTypes.elemType.getSubOptions [];

        ariaUserType = lib.types.submodule ({ name, ... }: {
            options =
                (removeAttrs nativeUserOptions [
                    "_module"
                    "isNormalUser"
                ]) // {
                    enable = lib.mkOption {
                        type = lib.types.bool;
                        default = true;
                    };

                    modules = lib.mkOption {
                        type = lib.types.listOf lib.types.deferredModule;
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
        options.aria.users = lib.mkOption {
            type = lib.types.attrsOf ariaUserType;
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
