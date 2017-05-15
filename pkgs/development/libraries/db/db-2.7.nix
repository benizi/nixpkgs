{ stdenv, fetchurl, ... } @ args:

import ./generic.nix (args // rec {
  version = "2.7.7";
  sha256 = "13jvcprls47zqd8zndxidvjk1pb5mcp98w83nh125zzhapd8rim7";
  extraPatches = [ ./db-2.7.patch ];

  cxxSupport = false; # TODO: old, old C++
  drvArgs.checkPhase = let
    examplePrograms = [
      "access"
      "appinit"
      "btrec"
      "lock"
      "mpool"
      # "thread" # TODO: fails compilation (missing pthreads dep?)
      "tpcb"
    ];
    targets = map (prog: "ex_${prog}") examplePrograms;
    examples = builtins.concatStringsSep " " targets;
  in ''
    make ${examples}
  '';
})
