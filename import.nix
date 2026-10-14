# Usage:
#   # flake.nix
#   outputs = inputs @ { self, ... }:
#     let
#       modules = (inputs.import-tree ./modules).imports;
#     in
#     inputs.flake-parts.lib.mkFlake { inherit inputs; } {
#       systems = [ "x86_64-linux" ];
#       imports = modules;
#     };
#
# or directly:
#   let importTree = import ./import-tree.nix;
#   in importTree ./modules # => { imports = [ <module 1> <module 2> ... ]; }

basePath:

let
  hasPrefix = prefix: str:
    let n = builtins.stringLength prefix;
    in builtins.substring 0 n str == prefix;

  hasSuffix = suffix: str:
    let
      lenStr = builtins.stringLength str;
      lenSuf = builtins.stringLength suffix;
    in
    lenStr >= lenSuf
    && builtins.substring (lenStr - lenSuf) lenSuf str == suffix;

  # Recursively walk `dir`, returning a flat list of importable .nix paths.
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
{
    imports = map import (walk basePath);
}
