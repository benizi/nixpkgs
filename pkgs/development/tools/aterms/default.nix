{ stdenv, pkgs, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "aterms-${version}";
  version = "0.0.1";
  buildInputs = with pkgs; [
    autoconf
    automake
    gettext
    libtool
    metaBuildEnv
  ];
  src = fetchFromGitHub {
    owner = "cwi-swat";
    repo = "aterms";
    rev = "c83b32402a96eb2137dced6004ab36629b33919a";
    sha256 = "1cmgd7wz6bzvk2vprf0i2rri1cp095w69razk49wjlxgisisp92l";
  };
}
