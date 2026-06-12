{
  pkgs,
  config,
  lib,
  ...
}:
let
  themePlugin = pkgs.callPackage ./plugin/package.nix { };
  cfg = config.stylix.targets.jetbrains;
in
{
  options.stylix.targets.jetbrains = {
    enable = config.lib.stylix.mkEnableTarget "Jetbrains IDE's" true;

    ideSupport = lib.mkOption {
      description = "The Jetbrains IDE's names to apply styling on.";
      type = lib.types.listOf lib.types.str;
      example = [ "idea-oss" ];
      default = [
        # keep-sorted start block=no
        "clion"
        "datagrip"
        "dataspell"
        "gateway"
        "goland"
        "idea"
        "idea-oss"
        "mps"
        "phpstorm"
        "pycharm"
        "pycharm-oss"
        "rider"
        "ruby-mine"
        "rust-rover"
        "webstorm"
        # keep-sorted end
      ];
    };
  };

  overlay =
    lib.optionalAttrs (config.stylix.enable && cfg.enable) lib.genAttrs
      "jetbrains.${cfg.ideSupport}"
      (
        name: pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.${name} [ themePlugin ]
      );
}
