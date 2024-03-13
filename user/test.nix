{ ... }:

let 
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  configFiles = lib.filesystem.listFilesRecursive "/home/stormytuna/.dotfiles/user/configs";
  configsList = builtins.map (file: { name = (builtins.replaceStrings [".dotfiles/user/configs"] [".config"] (toString file)); value = (toString file); }) configFiles;
  configsAttr =  builtins.listToAttrs configsList;
  final = builtins.mapAttrs (name: value: { "${name}".source = value; }) configsAttr;
in
{
  test = builtins.trace (lib.debug.traceValSeqN configsList);
}