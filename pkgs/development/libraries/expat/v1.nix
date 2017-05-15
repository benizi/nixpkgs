{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "expat-1.95.8";

  src = fetchurl {
    url = "mirror://sourceforge/expat/${name}.tar.gz";
    sha256 = "1jlix080040nlfyxj8q7fqi0y4g586p7aslmbbys0xg74ysa1an6";
  };

  # TODO: --docdir in configureFlags
  #outputs = [ "out" "dev" ]; # TODO: fix referrers
  #outputBin = "dev";
  outputs = ["out"];
  outputBin = "out";

  configureFlags = stdenv.lib.optional stdenv.isFreeBSD "--with-pic";

  #outputMan = "dev"; # tiny page for a dev tool
  outputMan = "out";

  doCheck = true;

  meta = with stdenv.lib; {
    homepage = http://www.libexpat.org/;
    description = "A stream-oriented XML parser library written in C";
    platforms = platforms.all;
    license = licenses.mit; # expat version
  };
}

