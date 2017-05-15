{ stdenv, fetchurl, makeWrapper, pkgsi686Linux }:

let
  expat = pkgsi686Linux.expat;
in stdenv.mkDerivation rec {
  name = "wink-${version}";
  version = "14";

  src = fetchurl {
    url = http://www.afterdawn.com/software/general/download.cfm/wink_for_linux?mirror_id=0&version_id=2005&software_id=1047;
    sha256 = "589ecb099bb34c937ffb4624caf6c79b4c8a8f5860afcb9764c6745fa15737ea";
    name = "wink.tar.gz";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = with pkgsi686Linux; [
    atk
    expat1
    freetype
    gdk_pixbuf
    glib
    gtk2
    libstdcxx5
    pango
    pangox_compat
    xlibs.libX11
    xlibs.libXext
    xlibs.libXi
  ];

  unpackPhase = ''
    mkdir -p "$out"
    tar -O -zxf "$src" installdata.tar.gz |
    tar -C "$out" -zx
  '';

  configurePhase = "true";

  dontBuild = true;

  dontStrip = true;

  installPhase = ''
    makeWrapper "$out"/wink "$out"/bin/wink
    patchelf \
      --set-interpreter "$(cat "${stdenv.cc}/nix-support/dynamic-linker-m32")" \
      --set-rpath "${stdenv.lib.makeLibraryPath buildInputs}" \
      "$out"/wink
  '';

  meta = with stdenv.lib; {
    description = "blah"; # TODO(benizi)
    homepage = http://www.debugmode.com/wink/;
    license = licenses.gpl2; # TODO(benizi) - not accurate...
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
