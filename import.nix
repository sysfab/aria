# import-tree.nix
#
# Minimal, dependency-free reimplementation of vic/import-tree
# (https://github.com/vic/import-tree).
#
# Recursively imports every `*.nix` file found under `basePath`.
# Unlike the original, this version takes ONLY the base path —
# no .filter/.match/.map chaining, no .addAPI, no extra options.
#
# Rules (matching import-tree's defaults):
#   - any path segment starting with "_" is skipped entirely
#     (files and directories)
#   - "default.nix" files are skipped (avoids self-import / duplicate
#     imports of directory defaults)
#   - everything else ending in ".nix" gets imported
#
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
#   in importTree ./modules   # => { imports = [ <module 1> <module 2> ... ]; }

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
