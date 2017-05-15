set -e
PATH=
for dir in "$gnutar" "$gcc" "$gnumake" "$coreutils" "$gawk" "$gzip" "$gnugrep" "$gnused" "$binutils"
do PATH="$PATH"${PATH+:}"$dir/bin"
done
export PATH
tar -xzf "$src"
cd hello-2.9
./configure --prefix="$out"
make
make install
