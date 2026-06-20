{
  pkgs,
  lib,
  mkTarget,
  ...
}:
mkTarget {
  autoEnable = pkgs.stdenv.hostPlatform.isLinux;
  autoEnableExpr = "pkgs.stdenv.hostPlatform.isLinux";
  config =
    { colors }:
    let
      configFile = colors {
        template = ./config.scss.mustache;
        extentsion = ".scss";
      };
    in
    {
      programs.eww.scssConfig = lib.mkBefore (
        pkgs.lib.concatStringsSep ",\n  " builtins.readFile configFile
      );
    };
}
