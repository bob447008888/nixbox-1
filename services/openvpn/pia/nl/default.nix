let
  server = import ../server.nix;
in
  server { remote = builtins.readFile ./remote.private; }
