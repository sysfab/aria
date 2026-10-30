path:
let
    inherit (builtins) stringLength substring;

    hasPrefix = prefix: str:
        let n = stringLength prefix;
        in substring 0 n str == prefix;

    hasSuffix = suffix: str:
        let n = stringLength suffix;
            len = stringLength str;
        in len >= n && substring (len - n) n str == suffix;

    walk = dir:
    let
        entries = builtins.readDir dir;
        names = builtins.attrNames entries;

        collect = name:
        let
            type = entries.${name};
            full = dir + "/${name}";
        in
        if hasPrefix "_" name then
            [ ]
        else if type == "directory" then
            walk full
        else if type == "regular" && hasSuffix ".nix" name && name != "default.nix" then
            [ full ]
        else
            [ ];
    in
    builtins.concatMap collect names;
in
map import (walk path)
