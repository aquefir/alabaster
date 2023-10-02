
## INSTALL LZLIB

stdbuf -o0 /bin/echo -n 'Downloading the source code for lzlib... ';
curl -fsSL 'https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.13.tar.gz' > lzlib.tar.gz;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Unpacking the tarball... ';
tar -xf lzlib.tar.gz;
cd lzlib-* || exit 127;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Configuring the build with autotools... ';
./configure CFLAGS='-march=native -mtune=native -O3 -pipe' \
            1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n \
       "Building with job control ($(nproc) threads)... ";
make -j"$(nproc)" 1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Installing lzlib... ';
make install 1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Cleaning up... ';
cd .. || exit 127;
rm -rf lzlib.tar.gz lzlib-*;
/bin/echo 'done.';

## INSTALL PLZIP

stdbuf -o0 /bin/echo -n 'Downloading the source code for plzip... ';
curl -fsSL 'https://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.10.tar.gz' > plzip.tar.gz;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Unpacking the tarball... ';
tar -xf plzip.tar.gz;
cd plzip-* || exit 127;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Configuring the build with autotools... ';
./configure CFLAGS='-march=native -mtune=native -O3 -pipe' \
            1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n \
       "Building with job control ($(nproc) threads)... ";
make -j"$(nproc)" 1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Installing plzip... ';
make install 1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Cleaning up... ';
cd .. || exit 127;
rm -rf plzip.tar.gz plzip-*;
/bin/echo 'done.';

## INSTALL TARLZ

stdbuf -o0 /bin/echo -n 'Downloading the source code for tarlz... ';
curl -fsSL 'https://download.savannah.gnu.org/releases/lzip/tarlz/tarlz-0.23.tar.lz' > tarlz.tar.lz;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Unpacking the tarball... ';
plzip -cd tarlz.tar.lz | tar -xf -;
cd tarlz-* || exit 127;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Configuring the build with autotools... ';
./configure CFLAGS='-march=native -mtune=native -O3 -pipe' \
            1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n \
       "Building with job control ($(nproc) threads)... ";
make -j"$(nproc)" 1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Installing tarlz... ';
make install 1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Cleaning up... ';
cd .. || exit 127;
rm -rf tarlz.tar.lz tarlz-*;
/bin/echo 'Done.';
