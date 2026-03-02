{ self, ... }:

{
    flake.nixosModules.user-example = { ... }: {
        users.users.example = {
            isNormalUser = true;

            extraGroups = [
                "wheel"
                "audio"
            ];
        };

        home-manager.users.example = {
            home.stateVersion = "25.05";

            imports = [
                self.homeModules.hyprland-config
                # add other stuff
            ];
        };
    };
}