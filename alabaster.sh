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
/bin/echo 'Installing packages with apt-get...';
DEBIAN_FRONTEND=noninteractive;
apt-get -qq install -qqy sudo git feh lz4 lzip plzip lightdm openbox \
	terminator gmrun thunar tint2 emacs-nox 2>&1 >/dev/null;
/bin/echo 'apt-get done.';

/bin/echo -n 'Downloading dotfiles... ';
cd /tmp;
git clone https://github.com/nicholatian/dotfiles.git dotfiles --quiet;
/bin/echo 'done.';
/bin/echo -n 'Installing dotfiles system-wide... ';
cd dotfiles;
./install.sh /root 2>&1 >/dev/null;
./install.sh /etc/skel 2>&1 >/dev/null;
gsettings set org.gnome.desktop.interface cursor-theme breeze-snow;
/bin/echo -n 'and for existing users... ';
for d in $(ls -1 /home); do
	./install.sh "/home/$d" 2>&1 >/dev/null;
	chown -R "$d":"$d" "/home/$d";
	runuser -l "$d" -c 'gsettings set org.gnome.desktop.interface cursor-theme
		breeze-snow';
done;
cd ..;
rm -rf dotfiles;
/bin/echo 'done.';

/bin/echo -n 'Downloading and unpacking distro data... ';
# tar will unpack these into the system root
cd /;
# piping makes it all async :)
wget -qO- -Uwget -o/dev/null https://alabaster.sh/data | \
	plzip -qdn $(nproc) - | tar -xf -;
/bin/echo 'done.';

# go home
cd;

/bin/echo 'All done.';
/bin/echo '';
/bin/echo 'It is recommended to reboot your system now.';
/bin/echo 'Enjoy Alabaster Linux!!!';
