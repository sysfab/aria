{ lib, ... }:

{
    flake.nixosModules.default-pickers = { ... }: {
        aria.pickers = {
            power = {
                name = "Power";
                order = lib.mkDefault 10;

                commands = {
                    shutdown = {
                        name = "Shutdown";
                        order = lib.mkDefault 10;

                        command = lib.mkDefault "shutdown now";
                    };

                    reboot = {
                        name = "Reboot";
                        order = lib.mkDefault 20;

                        command = lib.mkDefault "systemctl reboot";
                    };

                    logout = {
                        name = "Logout";
                        order = lib.mkDefault 30;

                        command = lib.mkDefault "sudo pkill -u \${USER}";
                    };
                };
            };

            actions = {
                name = "Quick actions";
                order = lib.mkDefault 20;

                commands = {};
            };
        };
    };

    flake.nixosModules.pickers = { config, pkgs, ... }:
    let
        inherit (lib) types;

        picker = types.submodule ({ name, ... }: {
            options = {
                name = lib.mkOption {
                    type = types.str;
                    default = name;
                    description = "Display name of the picker";
                };

                command = lib.mkOption {
                    type = types.nullOr types.str;
                    default = null;
                    description = "Command to execute";
                };

                commands = lib.mkOption {
                    type = types.attrsOf picker;
                    default = {};
                    description = "Nested picker entries";
                };

                order = lib.mkOption {
                    type = types.int;
                    default = 100;
                    description = "Display order (lower values appear first)";
                };
            };
        });

        validPicker = p:
            ((p.command != null) != (p.commands != {}))
            && lib.all validPicker (lib.attrValues p.commands);

        validNames = pickers:
            let
                names = lib.mapAttrsToList (_: p: p.name) pickers;
            in
                lib.length names == lib.length (lib.unique names)
                && lib.all
                    (p: validNames p.commands)
                    (lib.attrValues pickers);

        mkMenu = pickers:
            let
                entries = lib.sort
                    (a: b:
                        a.value.order < b.value.order
                        || (
                            a.value.order == b.value.order
                            && a.key < b.key
                        )
                    )
                    (lib.mapAttrsToList (key: value: {
                        inherit key value;
                    }) pickers);

                names = map (entry: entry.value.name) entries;

                cases = lib.concatStringsSep "\n" (
                    map (entry:
                        let
                            p = entry.value;
                        in
                        ''
                            ${lib.escapeShellArg p.name})
                                ${
                                    if p.command != null
                                    then p.command
                                    else mkMenu p.commands
                                }
                                ;;
                        ''
                    ) entries
                );
            in
            if pickers == {} then
                "exit 1"
            else ''
                choice="$(
                    printf '%s\n' ${lib.escapeShellArgs names} |
                        ${config.aria.picker.handler}
                )" || exit 1

                case "$choice" in
                    ${cases}
                    *)
                        exit 1
                        ;;
                esac
            '';
    in
    {
        options.aria = {
            picker.handler = lib.mkOption {
                type = types.str;
                default = "";
                description = "Command that returns the picked choice";
            };

            pickers = lib.mkOption {
                type = types.attrsOf picker;
                default = {};
                description = "Available picker entries";
            };
        };

        config = {
            environment.systemPackages = [
                (pkgs.writeShellScriptBin "aria-picker" (
                    mkMenu config.aria.pickers
                ))
            ];

            assertions = [
                {
                    assertion = config.aria.picker.handler != "";
                    message = "aria.picker.handler must be defined";
                }
                {
                    assertion = lib.all validPicker (
                        lib.attrValues config.aria.pickers
                    );
                    message = "Each picker must define either command or non-empty commands, but not both";
                }
                {
                    assertion = validNames config.aria.pickers;
                    message = "Picker display names must be unique within each menu";
                }
            ];
        };
    };
}
