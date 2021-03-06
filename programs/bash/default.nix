{ pkgs, ... }:

{
  enableCompletion = true;
  shellAliases = import ./aliases.nix;
  promptInit = builtins.readFile ./prompt.sh;
  interactiveShellInit = ''
    ${builtins.readFile ./bashrc}
    . ${pkgs.fzf}/share/fzf/key-bindings.bash
    . ${pkgs.etcdots}/share/etcdots/key-bindings.bash
  '';
}
