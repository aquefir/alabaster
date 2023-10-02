
# RHEL
if uname -a | grep -q '.el'; then

/bin/echo 'Alabaster does not support GUI installations on RHEL.';
/bin/echo 'Please use either Debian or Arch for that. Exiting...';
exit 127;

elif uname -a | grep -q ' Debian '; then

if lsb_release -d | grep -q '(buster)'; then
: # pass
elif lsb_release -d | grep -q '(bullseye)'; then
: # pass
elif lsb_release -d | grep -q '(bookworm)'; then
: # pass
else

/bin/echo 'Your version of Debian is either too old or too new.';
/bin/echo 'Alabaster supports Debian 10, 11 and 12. Exiting...';
exit 127;

fi

stdbuf -o0 /bin/echo -n 'Installing dependencies with apt-get... ';

apt-get -qq update 1>/dev/null 2>&1;
apt-get -qq install -qqy gpg 1>/dev/null 2>&1;

if lsb_release -d | grep -q '(buster)'; then
echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser:/palemoon-GTK3/Debian_10/ /' > /etc/apt/sources.list.d/palemoon-gtk3.list;
curl -fsSL 'https://download.opensuse.org/repositories/home:stevenpusser:palemoon-GTK3/Debian_10/Release.key' | gpg --dearmor > /etc/apt/trusted.gpg.d/home_stevenpusser_palemoon-GTK3.gpg;
elif lsb_release -d | grep -q '(bullseye)'; then
echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser:/palemoon-GTK3/Debian_11/ /' > /etc/apt/sources.list.d/palemoon-gtk3.list;
curl -fsSL 'https://download.opensuse.org/repositories/home:stevenpusser:palemoon-GTK3/Debian_11/Release.key' | gpg --dearmor > /etc/apt/trusted.gpg.d/home_stevenpusser_palemoon-GTK3.gpg;
elif lsb_release -d | grep -q '(bookworm)'; then
echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser:/palemoon-GTK3/Debian_12/ /' > /etc/apt/sources.list.d/palemoon-gtk3.list;
curl -fsSL 'https://download.opensuse.org/repositories/home:stevenpusser:palemoon-GTK3/Debian_12/Release.key' | gpg --dearmor > /etc/apt/trusted.gpg.d/home_stevenpusser_palemoon-GTK3.gpg;
fi

apt-get -qq update;

apt-get -qq install -qqy \
        sudo lz4 emacs-nox build-essential bison flex dh-autoreconf \
        libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev \
        asciidoc xmlto docbook2x install-info curl zip unzip git feh \
        lightdm openbox terminator gmrun thunar tint2 xbindkeys \
        scite palemoon \
        1>/dev/null 2>&1;

/bin/echo 'done.';

elif uname -a | grep -q '-arch'; then

stdbuf -o0 /bin/echo -n 'Installing dependencies with pacman... ';

pacman -S --noconfirm \
       wget curl autoconf automake binutils bison flex gcc gettext \
       libtool make patch perl-pkgconfig emacs-nox expat openssl zlib \
       perl zip unzip sudo lz4 asciidoc docbook2x feh lightdm openbox \
       terminator gmrun lightdm-gtk-greeter scite \
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
