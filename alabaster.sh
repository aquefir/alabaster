#!/bin/sh
# -*- coding: utf-8 -*-

if test "$(id -u)" -ne 0; then
	/bin/echo 'This script must be run as root. Exiting...';
	exit 127;
fi

/bin/echo 'Welcome to the Alabaster install script!';
/bin/echo -n 'Getting bearings... ';
cd; # start at home

/bin/echo 'done.';
/bin/echo -n 'Installing packages with apt... ';
apt-get -qq install -y sudo git feh lz4 lzip lightdm openbox terminator \
	gmrun thunar tint2 emacs-nox;
/bin/echo 'done.'

/bin/echo -n 'Downloading and unpacking distro data... ';
# tar will unpack these into the system root
cd /;
# piping makes it all async :)
wget -qO- https://alabaster.sh/data | plzip -dn $(nproc) - | tar -xf -;
/bin/echo 'done.';

# go home
cd;

/bin/echo 'All done.';
/bin/echo '';
/bin/echo 'It is recommended to reboot your system now.';
/bin/echo 'Enjoy Alabaster Linux!!!';
