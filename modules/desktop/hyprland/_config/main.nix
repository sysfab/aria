{}:

let
    env = import ./env.nix {};
    inputs = import ./inputs.nix {};
    misc = import ./misc.nix {};
    autostart = import ./autostart.nix {};

    look_animations = import ./look/animations.nix {};
    look_decoration = import ./look/decoration.nix {};
    look_general = import ./look/general.nix {};

    plugins_overview = import ./plugins/overview.nix {};
in
env //
inputs // 
misc //
autostart //
look_animations //
look_decoration //
look_general //
plugins_overview