stdbuf -o0 /bin/echo -n 'Downloading the source code for {{1}}... ';
curl -fsSL '{{2}}' > '{{1}}.tar.{{3}}';
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Unpacking the tarball... ';
if test '{{3}}' = 'lz'; then
plzip -cd '{{1}}.tar.lz' | tar -xf -;
else
tar -xf '{{1}}.tar.{{3}}';
fi
cd '{{1}}'-* || exit 127;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Configuring the build with autotools... ';
./configure CFLAGS='-march=native -mtune=native -O3 -pipe' \
            1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n \
       "Building with job control ($(nproc) threads)... ";
make -j"$(nproc)" 1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Installing {{1}}... ';
make install 1>/dev/null 2>&1;
/bin/echo 'done.';
stdbuf -o0 /bin/echo -n 'Cleaning up... ';
cd .. || exit 127;
rm -rf '{{1}}.tar.gz' '{{1}}-*';
/bin/echo 'done.';
