
# RHEL
if uname -a | grep -q '.el'; then

# pass. initrhel shows up later to execute unconditionally

elif uname -a | grep -q ' Debian '; then

if lsb_release -d | grep -q '(buster)'; then
elif lsb_release -d | grep -q '(bullseye)'; then
elif lsb_release -d | grep -q '(bookworm)'; then
else

/bin/echo 'Your version of Debian is either too old or too new.';
/bin/echo 'Alabaster supports Debian 10, 11 and 12. Exiting...';
exit 127;

fi

stdbuf -o0 /bin/echo -n 'Installing dependencies with apt-get... ';

apt-get -qq install -qqy \
        sudo lz4 emacs-nox build-essential bison flex dh-autoreconf \
        libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev \
        asciidoc xmlto docbook2x install-info curl zip unzip git lzop \
        arj bzip2 gzip zstd ncompress xz-utils \
        1>/dev/null 2>&1;

/bin/echo 'done.';

elif uname -a | grep -q '-arch'; then

stdbuf -o0 /bin/echo -n 'Installing dependencies with pacman... ';

pacman -S --noconfirm \
       wget curl autoconf automake binutils bison flex gcc gettext \
       libtool make patch perl-pkgconfig emacs-nox expat openssl zlib \
       perl zip unzip sudo lz4 asciidoc docbook2x arj p7zip bzip2 \
       gzip lzop zstd ncompress xz \
       1>/dev/null 2>&1;

/bin/echo 'done.';

else

/bin/echo 'Could not determine your distro.';
/bin/echo 'Alabaster supports the following distros:';
/bin/echo ' -  CentOS 7 (CLI only)';
/bin/echo ' -  Rocky Linux/AlmaLinux 8 and 9 (CLI only)';
/bin/echo ' -  Arch Linux (CLI and GUI)';
/bin/echo ' -  Debian 10, 11 and 12 (CLI and GUI)';
/bin/echo '';
/bin/echo 'Please install a supported distro and try again.';
/bin/echo 'Exiting...';

exit 127;

fi
