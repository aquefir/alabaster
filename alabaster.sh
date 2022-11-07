#!/bin/sh
# -*- coding: utf-8 -*-
## ALABASTER.SH
## ALABASTER LINUX SINGLE-FILE INSTALLATION SCRIPT
## Available to command-line tools at alabaster.sh :)
##
## Released under Artisan Software Licence, version 1.1.
## <//aquefir.co/asl>
##
## Artisan Software Licence, version 1.1.
## Copyright (C) 2022 Aquefir. All rights reserved.
##
## Redistribution and use in source and binary forms are permitted, provided
## that ALL of the following conditions are met:
## 1. Derivative works of the source code cannot be distributed unless express
##    written consent to do so has been given by the copyright holder(s); AND
## 2. Distributions in binary form must reproduce the above copyright notice,
##    this list of conditions and the following disclaimer in the documentation
##    and/or other materials provided with the distribution.
## 
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
## AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
## ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
## LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
## CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
## SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
## INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
## CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
## ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
## POSSIBILITY OF SUCH DAMAGE.

if test "$(id -u)" -ne 0; then
	/bin/echo 'This script must be run as root. Exiting...';
	exit 127;
elif test "$SUDO_USER" != ''; then
	/bin/echo 'This script cannot be run with sudo.';
	/bin/echo 'Please log in as root and try again. Exiting...';
	exit 127;
fi

/bin/echo '';
/bin/echo '';
/bin/echo 'Welcome to the Alabaster install script!';
/bin/echo '';
/bin/echo 'Released under Artisan Software Licence, version 1.1.';
/bin/echo '<//aquefir.co/asl>';
/bin/echo "Full licence text available in this script's source.";
/bin/echo '';
/bin/echo '';
/bin/echo -n 'Getting bearings... ';
cd || exit 127; # start at home

/bin/echo 'done.';

if uname -a | grep -q '.el7.'; then
	/bin/echo -n 'Installing dependencies with yum... ';
	yum install -y wget autoconf automake binutils bison flex gcc gcc-c++ \
	    gettext libtool make patch pkgconfig emacs-nox curl-devel expat-devel \
	    gettext-devel openssl-devel zlib-devel perl-CPAN perl-devel zip unzip \
	    1>/dev/null 2>&1;
	/bin/echo 'done.';
elif uname -a | grep -q ' Debian ' && lsb_release -d | grep -q '(buster)'; then
	/bin/echo 'Installing packages with apt-get...';
	export DEBIAN_FRONTEND=noninteractive;
	apt-get -qq install -qqy sudo feh lz4 lightdm openbox terminator gmrun \
	        thunar tint2 emacs-nox build-essential bison flex dh-autoreconf \
	        libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev \
	        asciidoc xmlto docbook2x install-info curl zip unzip \
	        1>/dev/null 2>&1;
	/bin/echo 'apt-get done.';
else
	/bin/echo 'Unsupported version of UNIX.';
	/bin/echo 'Alabaster supports Debian Buster for GUI installation and';
	/bin/echo 'CentOS 7 for CLI installation in Marble Edition mode.';
	/bin/echo 'Exiting...';
	exit 127;
fi

## INSTALL GIT

/bin/echo -n 'Downloading the source code for git... ';
curl -fsSL 'https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.38.1.tar.gz' > git.tar.gz;
/bin/echo 'done.';
/bin/echo -n 'Unpacking the tarball... ';
tar -xf git.tar.gz;
cd git-* || exit 127;
/bin/echo 'done.';
/bin/echo -n 'Configuring the build with autotools... ';
make configure 1>/dev/null 2>&1;
./configure --with-libpcre2 --with-editor=emacs --without-tcltk \
            1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n "Building with job control ($(nproc) threads)... ";
make -j"$(nproc)" 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Installing git... ';
make install 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Cleaning up... ';
cd .. || exit 127;
rm -rf git.tar.gz git-*;
/bin/echo 'done.';

## INSTALL LZLIB

/bin/echo -n 'Downloading the source code for lzlib... ';
curl -fsSL 'https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.13.tar.gz' > lzlib.tar.gz;
/bin/echo 'done.';
/bin/echo -n 'Unpacking the tarball... ';
tar -xf lzlib.tar.gz;
cd lzlib-* || exit 127;
/bin/echo 'done.';
/bin/echo -n 'Configuring the build with autotools... ';
./configure 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n "Building with job control ($(nproc) threads)... ";
make -j"$(nproc)" 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Installing lzlib... ';
make install 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Cleaning up... ';
cd .. || exit 127;
rm -rf lzlib.tar.gz lzlib-*;
/bin/echo 'done.';

## INSTALL PLZIP

/bin/echo -n 'Downloading the source code for plzip... ';
curl -fsSL 'https://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.10.tar.gz' > plzip.tar.gz;
/bin/echo 'done.';
/bin/echo -n 'Unpacking the tarball... ';
tar -xf plzip.tar.gz;
cd plzip-* || exit 127;
/bin/echo 'done.';
/bin/echo -n 'Configuring the build with autotools... ';
./configure 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n "Building with job control ($(nproc) threads)... ";
make -j"$(nproc)" 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Installing plzip... ';
make install 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Cleaning up... ';
cd .. || exit 127;
rm -rf plzip.tar.gz plzip-*;
/bin/echo 'done.';

## INSTALL TARLZ

/bin/echo -n 'Downloading the source code for tarlz... ';
curl -fsSL 'https://download.savannah.gnu.org/releases/lzip/tarlz/tarlz-0.23.tar.lz' > tarlz.tar.lz;
/bin/echo 'done.';
/bin/echo -n 'Unpacking the tarball... ';
plzip -cd tarlz.tar.lz | tar -xf -;
cd tarlz-* || exit 127;
/bin/echo 'done.';
/bin/echo -n 'Configuring the build with autotools... ';
./configure 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n "Building with job control ($(nproc) threads)... ";
make -j"$(nproc)" 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Installing tarlz... ';
make install 1>/dev/null 2>&1;
/bin/echo 'done.';
/bin/echo -n 'Cleaning up... ';
cd .. || exit 127;
rm -rf tarlz.tar.lz tarlz-*;
/bin/echo 'Done.';

## INSTALL ADOBE FONTS

if uname -a | grep -q 'Debian'; then
	/bin/echo -n 'Downloading Source Code Pro... ';
	curl -fsSL 'https://github.com/adobe-fonts/source-code-pro/releases/download/2.038R-ro%2F1.058R-it%2F1.018R-VAR/TTF-source-code-pro-2.038R-ro-1.058R-it.zip' > source-code-pro.zip;
	/bin/echo 'done.';
	/bin/echo -n 'Downloading Source Sans Pro... ';
	curl -fsSL 'https://github.com/adobe-fonts/source-sans/releases/download/3.046R/TTF-source-sans-3.046R.zip' > source-sans.zip;
	/bin/echo 'done.';
	/bin/echo -n 'Downloading Source Serif Pro... ';
	curl -fsSL 'https://github.com/adobe-fonts/source-serif/releases/download/4.004R/source-serif-4.004.zip' > source-serif.zip;
	/bin/echo 'done.';
	/bin/echo -n 'Downloading & installing Source Han Mono... ';
	mkdir -p /usr/local/share/fonts/alabaster;
	curl -fsSL 'https://github.com/adobe-fonts/source-han-mono/releases/download/1.002/SourceHanMono.ttc' > /usr/local/share/fonts/alabaster/SourceHanMono.ttc;
	/bin/echo 'done.'
	/bin/echo -n 'Downloading Source Han Sans... ';
	curl -fsSL 'https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSans.ttc.zip' > source-han-sans.zip;
	/bin/echo 'done.';
	/bin/echo -n 'Downloading Source Han Serif... ';
	curl -fsSL 'https://github.com/adobe-fonts/source-han-serif/releases/download/2.001R/01_SourceHanSerif.ttc.zip' > source-han-serif.zip;
	/bin/echo -n 'Creating Alabaster font folder in /usr/local... ';
	mkdir -p /usr/local/share/fonts/alabaster;
	/bin/echo 'done.';
	/bin/echo -n 'Unpacking Source Code Pro... ';
	unzip -q source-code-pro.zip -x LICENSE.md \
			-d /usr/local/share/fonts/alabaster/;
	/bin/echo 'done.';
	/bin/echo -n 'Unpacking Source Sans Pro... ';
	unzip -q source-sans.zip -d /usr/local/share/fonts/alabaster/;
	/bin/echo 'done.';
	/bin/echo -n 'Unpacking Source Serif Pro... ';
	unzip -q source-serif.zip 'source-serif-4.004/TTF/*.ttf' \
			-d /usr/local/share/fonts/alabaster/;
	/bin/echo 'done.';
	# no Source Han Mono to extract...
	/bin/echo -n 'Unpacking Source Han Sans... ';
	unzip -q source-han-sans.zip -d /usr/local/share/fonts/alabaster/;
	/bin/echo 'done.';
	/bin/echo -n 'Unpacking Source Han Serif... ';
	unzip -q source-han-serif.zip -d /usr/local/share/fonts/alabaster/;
	/bin/echo 'done.';
	/bin/echo -n 'Cleaning up font packages... ';
	rm source-*.zip;
	/bin/echo 'done.';
	/bin/echo -n 'Extracting default wallpaper... ';
	mkdir -p /usr/local/share/wallpapers;
	/bin/echo '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' | base64 -d > /usr/share/wallpapers/default.png;
	/bin/echo 'done.';
	/bin/echo -n 'Downloading SkeuOS GTK+ theme... ';
	curl -fsSL 'https://github.com/daniruiz/skeuos-gtk/archive/refs/tags/20220629.tar.gz' > skeuos.tar.gz;
	/bin/echo 'done.';
	/bin/echo -n 'Installing SkeuOS GTK+ theme... ';
	mkdir -p /usr/share/themes;
	tar -xf skeuos.tar.gz;
	cd skeuos-* || exit 127;
	cp -r themes/Skeuos-Grey-Dark /usr/share/themes/skeuos-grey-dark;
	cp -r themes/Skeuos-Grey-Dark-GNOME_40+41/gnome-shell \
		/usr/share/themes/skeuos-grey-dark/gnome-shell;
	cp -r themes/Skeuos-Grey-Dark-FullPanel-GNOME_40+41 \
		/usr/share/themes/skeuos-grey-dark-fullpanel;
	cd .. || exit 127;
	rm -rf skeuos-* skeuos.tar.gz;
	/bin/echo 'done.';
	/bin/echo -n 'Extracting Fumaca 2.0 Openbox theme... ';
	mkdir -p /usr/share/themes;
	cwd="$PWD";
	cd /usr/share/themes || exit 127;
	/bin/echo 'H4sICMQvWmMCAGZ1bWFjYTIudGFyAO1ZXc+TMBTmVn5FE2800dlCoXPGxG9vNDF6aYwpULZqgQU6nTH+d6GARcBVjTYm9lnSF3qefvCe85y2kJ8KmtLglvcXASGGhBAP9pj/VdcIh0GMAxLHqK0nIY48EHkWcGokrdshvf8To/+rIyuT6nwzXEaCff8jhCLi/G8DS/8nJyGY3JyT4o/5H8GL/kcEeSgMURREmERhy++uPbDqE+f/P4qrGct5yUDv9bcfeSYPIPJn1QfG9wfZ1jeSSp6CU9nwfckykB5oPZISLpvXb8Bd8NkHAMAzhDd+UIIvd3zP4V/AUv+pqBqm5G9L/yH+pv84glHLD0iMnf5tYBS68vogf4T876pH+SO0rn9FWso/VGKPVUl0uWU3vlmzVF2jrsy3OkWQMV30XWmTbjLvSg+hh3Z55jf0n7HmvZK/Nf0HMJqt/0EMidO/DYxC77w+yH/rTytH8W9Xta8oF1d+rLRL+jLX13jr9gL/ANb1/1ZW+71gWZcHLOg/mO//cYjc/t8KtNS114c8EPtrxjEfxD/MB5q6nhcQU2UwKZnLBZZg1j9Pq5Lnn5T0be3/yaD/GEIcebC7ceu/BWj9D17XJ4CZwXAGGGl/9hSA1DUeTgFBoG77Eusm20mTCOrrwL1t+B39F/SstW9H/2E4rv8kQur8j7HTvwVo/bde19qfVBp0ryhzzQdwTZBaqHMBa2FrzbuTvx0s9f/y8f1Hzx97FvWPYqS//wSk0z8Mnf6t4EpJC7YDfRiAIQqAPLCC+Vc+sLrhVQl2INjADfSvJJ924NmJluApTWrOBLj26sRTdt2/wgrKxQ6I1rjvbQ0XH2heMy5pc2/fmTdpVThV/ltY6r850Mzu+39E8Pz9H3Hf/2xAr//K6/rgP601nPgVZ7EHCPMbqnSfAP9tLPWvcn+d2lv/Q4zC8fwfQ4Q7/UcBdPq3gat6yVduByzjkmXgI5cHUCWq1k+qOmP1RmWHHQj8gpWnTUsrmg1NJf/ANsl+B54IKsGrSvBslbBJK1HVO3AVEZQEcIUj2Vl+Y8WP78MHeMK6MMbFzjPe0ESw7Pvub8P2N+XNR98+vD+Yqw+sFvS4A1F/L7kUK0+sLXo2JKQkmTZTo5jM79qY5Hm31WK59KsmU4Pl3WC9J0A7I8lTKgbj7KnG2p48G60zGiza1UjVCZowoeZwpDUrZc0E7RymjauPdaRZxsv92Bf0P/Iyqz6O3tZz0I5bcE5SVqV24eyfbiL/Wue8oHv2rUmad7/1JseaNY15Opr787M5lYbOZ+zf7t78tBO/v/jO7zOajoCLU1jXzTrlBx0daJkJtggoXv5cuJjpy3F1C3PIREH3mzYyB42BbZqTOXAM/N8awvzc5vDRRHMA8dIQQppkDiI9mk60guXSbUcdHBz+L3wFZZHUYAAyAAA=' | base64 -d | gunzip -cd | tar -xf -;
	cd "$cwd" || exit 127;
	curl -fsSL 'https://code.jpope.org/jpope/breeze_cursor_sources/raw/master/breeze-snow-cursor-theme.zip' > breeze-snow.zip;
	if ! sha256sum breeze-snow.zip \
			| grep -q '1390272e693f258dc55f86fbd5c99f0f36cfb4e71f22e9062b8d6ff14483562e'; then
		/bin/echo 'hold it!';
		/bin/echo 'Checksum failure found for breeze-snow.zip.';
		/bin/echo 'This is probably a bug caused by the upstream URL going bad.';
		/bin/echo 'Skipping...';
	else
		mkdir -p /usr/share/icons/default;
		unzip -q breeze-snow.zip -d /usr/share/icons/;
		test -d /usr/share/icons/breeze-snow && \
			rm -rf /usr/share/icons/breeze-snow;
		mv /usr/share/icons/Breeze_Snow /usr/share/icons/breeze-snow;
		/bin/echo 'done.';
	fi
	rm breeze-snow.zip;
	/bin/echo -n 'Setting up theme defaults... ';
	/bin/echo -e '[Icon Theme]\nInherits=breeze-snow' > /usr/share/icons/default/index.theme;
	/bin/echo 'done.';
	/bin/echo -n 'Downloading Papirus icon theme... ';
	cd /usr/share/icons || exit 127;
	curl -fsSL 'https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/refs/tags/20220910.tar.gz' > papirus.tar.gz;
	/bin/echo 'done';
	/bin/echo -n 'Installing Papirus icon theme... ';
	tar -xf papirus.tar.gz;
	mv papirus-* papirus-repo;
	test -d papirus && rm -rf papirus; # remove existing
	mv papirus-repo/Papirus papirus;
	rm -rf papirus-repo;
	rm papirus.tar.gz;
	/bin/echo 'done.';
	cd "$cwd" || exit 127;
	/bin/echo -n 'Configuring wallpaper defaults... ';
	mkdir -p /etc/dconf/db/local.d;
	/bin/echo -e "[org/gnome/desktop/background]\npicture-uri='file:///usr/share/wallpapers/default.png'" > /etc/dconf/db/local.d/01-background;
	/bin/echo 'done.';
	/bin/echo -n 'Configuring GTK+ defaults... ';
	mkdir -p /etc/gtk-2.0 /etc/gtk-3.0;
	/bin/echo -e '[Settings]\ngtk-theme-name=skeuos-grey-dark\ngtk-icon-theme-name=papirus\ngtk-font-name=Source Sans 3 10\ngtk-cursor-theme-name=breeze-snow\ngtk-cursor-theme-size=0\ngtk-toolbar-style=GTK_TOOLBAR_BOTH\ngtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR\ngtk-button-images=1\ngtk-menu-images=1\ngtk-enable-event-sounds=1\ngtk-enable-input-feedback-sounds=1\ngtk-xft-antialias=1\ngtk-xft-hinting=1\ngtk-xft-hintstyle=hintfull\ngtk-xft-rgba=rgb' > /etc/gtk-2.0/settings.ini;
	cp /etc/gtk-2.0/settings.ini /etc/gtk-3.0/settings.ini;
	mkdir -p "$HOME/.config/gtk-3.0";
	cp /etc/gtk-3.0/settings.ini "$HOME/.config/gtk-3.0/settings.ini";
	mkdir -p /etc/skel/.config/gtk-3.0;
	cp /etc/gtk-3.0/settings.ini /etc/skel/.config/gtk-3.0/settings.ini;
	/bin/echo 'done.';
	/bin/echo -n 'Configuring LightDM... ';
	mkdir -p /etc/lightdm;
	/bin/echo -e '[LightDM]\n[Seat:*]\ngreeter-session=lightdm-gtk-greeter\nuser-session=openbox\n[XDMCPServer]\n[VNCServer]' > /etc/lightdm/lightdm.conf;
	/bin/echo -e '[greeter]\ntheme-name=fumaca2\nicon-theme-name=papirus\ncursor-theme-name=breeze-snow\nfont-name=Source Sans Pro' > /etc/lightdm/lightdm-gtk-greeter.conf;
	/bin/echo 'done.';
	/bin/echo -n 'Configuring Openbox defaults... ';
	mkdir -p /etc/xdg/openbox;
	/bin/echo -e 'feh --bg-tile /usr/share/wallpapers/default.png &\ntint2 &' > /etc/xdg/openbox/autostart;
	/bin/echo '<?xml version="1.0" encoding="UTF-8"?><openbox_config xmlns="http://openbox.org/3.4/rc" xmlns:xi="http://www.w3.org/2001/XInclude"><resistance><strength>10</strength><screen_edge_strength>20</screen_edge_strength></resistance><focus><focusNew>yes</focusNew><followMouse>no</followMouse><focusLast>yes</focusLast><underMouse>no</underMouse><focusDelay>200</focusDelay><raiseOnFocus>no</raiseOnFocus></focus><placement><policy>Smart</policy><center>yes</center><monitor>Primary</monitor><primaryMonitor>1</primaryMonitor></placement><theme><name>fumaca2</name><titleLayout>NLIMC</titleLayout><keepBorder>yes</keepBorder><animateIconify>yes</animateIconify><font place="ActiveWindow"><name>Source Sans 3 Semi-Bold</name><size>12</size><weight>Normal</weight><slant>Normal</slant></font><font place="InactiveWindow"><name>Source Sans 3</name><size>12</size><weight>Normal</weight><slant>Normal</slant></font><font place="MenuHeader"><name>Source Sans 3</name><size>9</size><weight>Bold</weight><slant>Normal</slant></font><font place="MenuItem"><name>Source Sans 3</name><size>10</size><weight>Normal</weight><slant>Normal</slant></font><font place="ActiveOnScreenDisplay"><name>Source Sans 3 VF Heavy</name><size>15</size><weight>Normal</weight><slant>Italic</slant></font><font place="InactiveOnScreenDisplay"><name>Source Sans 3 VF</name><size>15</size><weight>Bold</weight><slant>Italic</slant></font></theme><desktops><number>1</number><firstdesk>1</firstdesk><names></names><popupTime>875</popupTime></desktops><resize><drawContents>yes</drawContents><popupShow>Nonpixel</popupShow><popupPosition>Center</popupPosition><popupFixedPosition><x>10</x><y>10</y></popupFixedPosition></resize><margins><top>0</top><bottom>0</bottom><left>0</left><right>0</right></margins><dock><position>TopLeft</position><floatingX>0</floatingX><floatingY>0</floatingY><noStrut>no</noStrut><stacking>Above</stacking><direction>Vertical</direction><autoHide>no</autoHide><hideDelay>300</hideDelay><showDelay>300</showDelay><moveButton>Middle</moveButton></dock><keyboard><chainQuitKey>C-g</chainQuitKey><keybind key="C-A-Left"><action name="GoToDesktop"><to>left</to><wrap>no</wrap></action></keybind><keybind key="C-A-Right"><action name="GoToDesktop"><to>right</to><wrap>no</wrap></action></keybind><keybind key="C-A-Up"><action name="GoToDesktop"><to>up</to><wrap>no</wrap></action></keybind><keybind key="C-A-Down"><action name="GoToDesktop"><to>down</to><wrap>no</wrap></action></keybind><keybind key="S-A-Left"><action name="SendToDesktop"><to>left</to><wrap>no</wrap></action></keybind><keybind key="S-A-Right"><action name="SendToDesktop"><to>right</to><wrap>no</wrap></action></keybind><keybind key="S-A-Up"><action name="SendToDesktop"><to>up</to><wrap>no</wrap></action></keybind><keybind key="S-A-Down"><action name="SendToDesktop"><to>down</to><wrap>no</wrap></action></keybind><keybind key="W-F1"><action name="GoToDesktop"><to>1</to></action></keybind><keybind key="W-F2"><action name="GoToDesktop"><to>2</to></action></keybind><keybind key="W-F3"><action name="GoToDesktop"><to>3</to></action></keybind><keybind key="W-F4"><action name="GoToDesktop"><to>4</to></action></keybind><keybind key="W-d"><action name="ToggleShowDesktop"/></keybind><keybind key="A-F4"><action name="Close"/></keybind><keybind key="A-Escape"><action name="Lower"/><action name="FocusToBottom"/><action name="Unfocus"/></keybind><keybind key="A-space"><action name="ShowMenu"><menu>client-menu</menu></action></keybind><keybind key="A-Print"><action name="Execute"><command>scrot -s</command></action></keybind><keybind key="A-Tab"><action name="NextWindow"><finalactions><action name="Focus"/><action name="Raise"/><action name="Unshade"/></finalactions></action></keybind><keybind key="A-S-Tab"><action name="PreviousWindow"><finalactions><action name="Focus"/><action name="Raise"/><action name="Unshade"/></finalactions></action></keybind><keybind key="C-A-Tab"><action name="NextWindow"><panels>yes</panels><desktop>yes</desktop><finalactions><action name="Focus"/><action name="Raise"/><action name="Unshade"/></finalactions></action></keybind><keybind key="W-S-Right"><action name="DirectionalCycleWindows"><direction>right</direction></action></keybind><keybind key="W-S-Left"><action name="DirectionalCycleWindows"><direction>left</direction></action></keybind><keybind key="W-S-Up"><action name="DirectionalCycleWindows"><direction>up</direction></action></keybind><keybind key="W-S-Down"><action name="DirectionalCycleWindows"><direction>down</direction></action></keybind><keybind key="W-e"><action name="Execute"><startupnotify><enabled>true</enabled><name>Konqueror</name></startupnotify><command>kfmclient openProfile filemanagement</command></action></keybind><keybind key="Print"><action name="Execute"><command>scrot</command></action></keybind></keyboard><mouse><dragThreshold>1</dragThreshold><doubleClickTime>500</doubleClickTime><screenEdgeWarpTime>400</screenEdgeWarpTime><screenEdgeWarpMouse>false</screenEdgeWarpMouse><context name="Frame"><mousebind button="A-Left" action="Press"><action name="Focus"/><action name="Raise"/></mousebind><mousebind button="A-Left" action="Click"><action name="Unshade"/></mousebind><mousebind button="A-Left" action="Drag"><action name="Move"/></mousebind><mousebind button="A-Right" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/></mousebind><mousebind button="A-Right" action="Drag"><action name="Resize"/></mousebind><mousebind button="A-Middle" action="Press"><action name="Lower"/><action name="FocusToBottom"/><action name="Unfocus"/></mousebind><mousebind button="A-Up" action="Click"><action name="GoToDesktop"><to>previous</to></action></mousebind><mousebind button="A-Down" action="Click"><action name="GoToDesktop"><to>next</to></action></mousebind><mousebind button="C-A-Up" action="Click"><action name="GoToDesktop"><to>previous</to></action></mousebind><mousebind button="C-A-Down" action="Click"><action name="GoToDesktop"><to>next</to></action></mousebind><mousebind button="A-S-Up" action="Click"><action name="SendToDesktop"><to>previous</to></action></mousebind><mousebind button="A-S-Down" action="Click"><action name="SendToDesktop"><to>next</to></action></mousebind></context><context name="Titlebar"><mousebind button="Left" action="Drag"><action name="Move"/></mousebind><mousebind button="Left" action="DoubleClick"><action name="ToggleMaximize"/></mousebind><mousebind button="Up" action="Click"><action name="if"><shaded>no</shaded><then><action name="Shade"/><action name="FocusToBottom"/><action name="Unfocus"/><action name="Lower"/></then></action></mousebind><mousebind button="Down" action="Click"><action name="if"><shaded>yes</shaded><then><action name="Unshade"/><action name="Raise"/></then></action></mousebind></context><context name="Titlebar Top Right Bottom Left TLCorner TRCorner BRCorner BLCorner"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/></mousebind><mousebind button="Middle" action="Press"><action name="Lower"/><action name="FocusToBottom"/><action name="Unfocus"/></mousebind><mousebind button="Right" action="Press"><action name="Focus"/><action name="Raise"/><action name="ShowMenu"><menu>client-menu</menu></action></mousebind></context><context name="Top"><mousebind button="Left" action="Drag"><action name="Resize"><edge>top</edge></action></mousebind></context><context name="Left"><mousebind button="Left" action="Drag"><action name="Resize"><edge>left</edge></action></mousebind></context><context name="Right"><mousebind button="Left" action="Drag"><action name="Resize"><edge>right</edge></action></mousebind></context><context name="Bottom"><mousebind button="Left" action="Drag"><action name="Resize"><edge>bottom</edge></action></mousebind><mousebind button="Right" action="Press"><action name="Focus"/><action name="Raise"/><action name="ShowMenu"><menu>client-menu</menu></action></mousebind></context><context name="TRCorner BRCorner TLCorner BLCorner"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/></mousebind><mousebind button="Left" action="Drag"><action name="Resize"/></mousebind></context><context name="Client"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/></mousebind><mousebind button="Middle" action="Press"><action name="Focus"/><action name="Raise"/></mousebind><mousebind button="Right" action="Press"><action name="Focus"/><action name="Raise"/></mousebind></context><context name="Icon"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/><action name="ShowMenu"><menu>client-menu</menu></action></mousebind><mousebind button="Right" action="Press"><action name="Focus"/><action name="Raise"/><action name="ShowMenu"><menu>client-menu</menu></action></mousebind></context><context name="AllDesktops"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/></mousebind><mousebind button="Left" action="Click"><action name="ToggleOmnipresent"/></mousebind></context><context name="Shade"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/></mousebind><mousebind button="Left" action="Click"><action name="ToggleShade"/></mousebind></context><context name="Iconify"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/></mousebind><mousebind button="Left" action="Click"><action name="Iconify"/></mousebind></context><context name="Maximize"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/></mousebind><mousebind button="Middle" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/></mousebind><mousebind button="Right" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/></mousebind><mousebind button="Left" action="Click"><action name="ToggleMaximize"/></mousebind><mousebind button="Middle" action="Click"><action name="ToggleMaximize"><direction>vertical</direction></action></mousebind><mousebind button="Right" action="Click"><action name="ToggleMaximize"><direction>horizontal</direction></action></mousebind></context><context name="Close"><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/><action name="Unshade"/></mousebind><mousebind button="Left" action="Click"><action name="Close"/></mousebind></context><context name="Desktop"><mousebind button="Up" action="Click"><action name="GoToDesktop"><to>previous</to></action></mousebind><mousebind button="Down" action="Click"><action name="GoToDesktop"><to>next</to></action></mousebind><mousebind button="A-Up" action="Click"><action name="GoToDesktop"><to>previous</to></action></mousebind><mousebind button="A-Down" action="Click"><action name="GoToDesktop"><to>next</to></action></mousebind><mousebind button="C-A-Up" action="Click"><action name="GoToDesktop"><to>previous</to></action></mousebind><mousebind button="C-A-Down" action="Click"><action name="GoToDesktop"><to>next</to></action></mousebind><mousebind button="Left" action="Press"><action name="Focus"/><action name="Raise"/></mousebind><mousebind button="Right" action="Press"><action name="Focus"/><action name="Raise"/></mousebind></context><context name="Root"><mousebind button="Middle" action="Press"><action name="ShowMenu"><menu>client-list-combined-menu</menu></action></mousebind><mousebind button="Right" action="Press"><action name="ShowMenu"><menu>root-menu</menu></action></mousebind></context><context name="MoveResize"><mousebind button="Up" action="Click"><action name="GoToDesktop"><to>previous</to></action></mousebind><mousebind button="Down" action="Click"><action name="GoToDesktop"><to>next</to></action></mousebind><mousebind button="A-Up" action="Click"><action name="GoToDesktop"><to>previous</to></action></mousebind><mousebind button="A-Down" action="Click"><action name="GoToDesktop"><to>next</to></action></mousebind></context></mouse><menu><file>/var/lib/openbox/debian-menu.xml</file><file>menu.xml</file><hideDelay>200</hideDelay><middle>no</middle><submenuShowDelay>100</submenuShowDelay><submenuHideDelay>400</submenuHideDelay><showIcons>yes</showIcons><manageDesktops>yes</manageDesktops></menu><applications></applications></openbox_config>' > /etc/xdg/openbox/rc.xml;
	/bin/echo '<?xml version="1.0" encoding="UTF-8"?><openbox_menu xmlns="http://openbox.org/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://openbox.org/ file:///usr/share/openbox/menu.xsd"><menu id="root-menu" label="Openbox 3"><item label="Run command"><action name="Execute"><execute>gmrun</execute></action></item><item label="Terminal"><action name="Execute"><execute>terminator</execute></action></item><item label="File browser"><action name="Execute"><execute>thunar</execute></action></item><separator /><item label="Reconfigure"><action name="Reconfigure" /></item><item label="Restart"><action name="Restart" /></item><separator /><item label="Exit"><action name="Exit" /></item></menu></openbox_menu>' > /etc/xdg/openbox/menu.xml;
	mkdir -p "$HOME/.config/openbox";
	cp /etc/xdg/openbox/rc.xml "$HOME/.config/openbox/rc.xml";
	cp /etc/xdg/openbox/menu.xml "$HOME/.config/openbox/menu.xml";
	mkdir -p /etc/skel/.config/openbox;
	cp /etc/xdg/openbox/rc.xml /etc/skel/.config/openbox/rc.xml;
	cp /etc/xdg/openbox/menu.xml /etc/skel/.config/openbox/menu.xml;
	/bin/echo 'done.';
	/bin/echo -n 'Configuring terminal defaults... ';
	mkdir -p /etc/xdg/terminator;
	/bin/echo -e '[global_config]\n[keybindings]\n\tcopy = <Super>c\n\tpaste = <Super>v\n[profiles]\n\t[[default]]\n\t\tallow_bold = False\n\t\tbackground_darkness = 0.75\n\t\tbackground_type = transparent\n\t\tcursor_color = "#aaaaaa"\n\t\tfont = Source Code Pro Medium 10\n\t\tshow_titlebar = False\n\t\tscrollback_infinite = True\n\t\tlogin_shell = True\n\t\tuse_system_font = False\n[layouts]\n\t[[default]]\n\t\t[[[window0]]]\n\t\t\ttype = Window\n\t\t\tparent = ""\n\t\t[[[child1]]]\n\t\t\ttype = Terminal\n\t\t\tparent = window0\n[plugins]' > /etc/xdg/terminator/config;
	mkdir -p "$HOME/.config/terminator";
	cp /etc/xdg/terminator/config "$HOME/.config/terminator/config";
	mkdir -p /etc/skel/.config/terminator;
	cp /etc/xdg/terminator/config /etc/skel/.config/terminator/config;
	/bin/echo 'done.';
	/bin/echo -n 'Configuring file manager defaults... ';
	mkdir -p /etc/xdg/Thunar;
	/bin/echo -e '<?xml version="1.0" encoding="UTF-8"?><actions><action><icon>utilities-terminal</icon><name>Open terminal here</name><unique-id>1663722866309645-2</unique-id><command>terminator --working-directory="%f"</command><description>Opens a terminal session in the opened folder.</description><pattersn>*</patterns><startup-notify/><directories/></action></actions>' > /etc/xdg/Thunar/uca.xml;
	mkdir -p "$HOME/.config/Thunar";
	cp /etc/xdg/Thunar/uca.xml "$HOME/.config/Thunar/uca.xml";
	mkdir -p /etc/skel/.config/Thunar;
	cp /etc/xdg/Thunar/uca.xml /etc/skel/.config/Thunar/uca.xml;
	/bin/echo 'done.';
	## this file is "tint2rc.gz" in base64
	/bin/echo -n 'Configuring tint2 defaults... ';
	mkdir -p /etc/xdg/tint2;
	/bin/echo 'H4sICMhQWmMCA3RpbnQycmMAzVhLb+M2EL77V7AIgm2B3ViynXprIIfuFtgWSIGiSQ89CbRE2UQoUiCp9Xp/fYdDUg/LduweuqUDO/rmQc43wyHtm3cwyCcmmaaWFWS9J5ZLO8uVLMkiXd4TpzC5IU+Mka21tVlNpxtuBV3f5aqaqp+SJJmiyXTHX7iZfgRLvmk0I6XSBCzLRghSqLypmLTUciWJKondMpIH1QDW7sPcTW7eXTLA8ydNCw5OzeUmH2j+stGqkYUZPJF0Rf6gkokJPgITDySZrJUumM52vLDbPmB4wQwAzx8e/4wYBGNhLZnjItsxvtlab9LOcZmKANYeyE2CgyzvO/9Dydgs26rPrK/yfjkwHsmPuKg1Mwajj0ppkgy9jFWSyZDL2Yr8wkraCEssNS9vyW8QOS85GLnnHsWLb0nxsnQvcp+MKA6ScxQHlYP8jOTnKQ5Kh3kaaxwyPF+Rn3PLP7NXCU3/S0JxkNmY0BIHWZxjlOIgs9kJRhl1L7JYnKX0HkfHw0ihczOkdLEif+kNhPq/opTSxeLIJvSi5XI+96KTpOb5cnlsE/dYP+3lGlp7foa83q/Is1LC8rrHafotOZ3hOMrpHMcrnLpShkI9zWm/c57h9JSf4z348jPOn2O1e8+4ZZWj8/H56WOADP/KHONJcus2pAcrqjdcOspIhGpaFFxuAHtPFpB5j/YC4j6TuyqDk73B/70OHPYvyH5wxD8rmxmrG2v6sDIcD/4HYlVNckgf0LdVmn+FZNIYgaB7ZHWtrFVVXC6cJxZTVmsOa9/H2LaaSz83bazaQjENHkBB7aBIKqYaO5TgW09yd9+TxYKaTTAMWLvg+R6AUgkBHh2nYQk7LgtAJK3c1HgzmhTc0LUA95pKU1PNJBqnk0o1hmWsLFmO3KSTEmKHVVLwgevzGlhaGYcqz6hZ++wRVxdBHkpmrAG92OQUptZMUHdgZFZlRc3R91hics2Y7OK9puyeoW2uqZ5Y/wk5QvIN1BDMArv6BdLcSpFXXmasqu0eZ4qSru4wgBY/rLzOguJReEYhJCM5mF0GQ4easbzgkBftukpXbidVQnzDdYkd3Rtfc1SIqHNkPrfAXuCLXtgoOh/aZQRkWFptq2Nz98LWcszXUDmc331lqGmr+bqxLHaUTmaUthm2NIClkgwlwAHfuO0uWGmvLCzvwLIvtp0Iix33DD75/hFOlwZP8kyuM1Vma+F7QorN1GtX9Auvmiouff4j/HlJPwuu7fmJ/QnWzWa3TbWWlItuOS0Unc7SIDnL5Shrs0DW8ZzOvTQEeChddMzgffuIc98wXAqw8W7c5vT6+yCreFEIFjPnMR0aQi6UiRg0C+h+WVO3joYCaGEuP9H55Ql/2hs4tgh0yz35XioLoeT+OyK0TvrDxIAcZINO4bZMxMf7IEpcYQJADVSLM20F2Dhj3hZDuN9PO1ddT0hbzG8zLiwW/hURP9JG5lumJyL804tthrG1gnFwrQhX+5q8C3KID6McyuDLOgTmziAdT1RjqbZNnfXT40+w1rS/aTp/kNmM1g6dNkZP4ajTbAqAiE6mm0o38i4eGNdYAu8VdHVIy78z3zaSnjdtfxxptS5P8kcB96KJu2Kk0BJ0RV0p3v66uv19dfuE+KyH07fkdk1uC/j4Oxi5d7gbuQQE9T6SO/ene40X98sqYuOK8XiXvyFwZFaRA4vQg1VVUVl0uD7ElaYbFoTVCaNmt2VwkRrhxQi/5ncfC8Wxh/s4fg5qM2J4kbPUNljHyQDPKzfhlwquWRAAeYN1sIpuCah896Y1cL94BYsOO5UXUOiVg3ucDR/RvMtbSrqVjTMXJeHmmya98EZ0R4k+KalOSsZJipJxmmjuvp9JuOPCiRR4AQxuECP4iltB+FIZi/LwZg/39ygaXe3TVjQ47Vv0kNfO1TCNBQ5M4z+dO5opSRUAAA==' \
		| base64 -d | gunzip -dc > /etc/xdg/tint2/tint2rc;
	mkdir -p "$HOME/.config/tint2";
	cp /etc/xdg/tint2/tint2rc "$HOME/.config/tint2/tint2rc";
	mkdir -p /etc/skel/.config/tint2;
	cp /etc/xdg/tint2/tint2rc /etc/skel/.config/tint2/tint2rc;
	cwd="$PWD";
	cd /usr/share/applications;
	ln -sf Thunar.desktop thunar.desktop;
	cd "$cwd";
	/bin/echo 'done.';
	/bin/echo -n 'Configuring XDG defaults... ';
	/bin/echo -n '' > /etc/xdg/user-dirs.defaults;
	/bin/echo -e 'enabled=False\nfilename_encoding=UTF-8' > /etc/xdg/user-dirs.conf;
	/bin/echo 'done.';
fi

cd; # go home

/bin/echo -n 'Configuring sudoers defaults... ';
mkdir -p /etc/sudoers.d;
/bin/echo -e '%sudo\tALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/sudo-nopasswd;
/bin/echo 'done.';
/bin/echo -n 'Downloading dotfiles... ';
curl -fsSL 'https://github.com/aquefir/dotfiles/archive/refs/heads/master.tar.gz' > dotfiles.tar.gz;
/bin/echo 'done.';
tar -xf dotfiles.tar.gz;
cd dotfiles-* || exit 127;
sh util/tarball.sh src "/tmp/out.tar";
/bin/echo -n 'Installing the dotfiles into /etc/skel... ';
cd /etc/skel || exit 127;
tar -xf "/tmp/out.tar";
/bin/echo 'done.';
/bin/echo -n 'Installing the dotfiles into /root... ';
cd /root || exit 127;
tar -xf "/tmp/out.tar";
/bin/echo 'done.';
/bin/echo -n 'Installing the dotfiles into /home subdirectories... ';
for dir in $(ls -A1 /home); do
	/bin/echo -n "/home/$dir... ";
	cp -r /etc/skel/. "/home/$dir/";
	chown -R "$dir":"$dir" "/home/$dir";
done
/bin/echo 'done.';
/bin/echo -n 'Cleaning up dotfiles staging... ';
cd; # go home
rm -rf dotfiles-* dotfiles.tar.gz /tmp/out.tar;
/bin/echo 'done.'

/bin/echo '';
/bin/echo 'Setup is now complete.';
/bin/echo '';
/bin/echo 'You may now reboot into your new installation!';
/bin/echo '';
/bin/echo 'Before leaving, you may wish to create additional users; if any of';
/bin/echo 'them need sudo privileges, the system is already configured to';
/bin/echo 'give it to all members of the sudo usergroup (usermod -aG sudo).';
/bin/echo '';
/bin/echo 'This is also a good time to install any credentials, such as SSH';
/bin/echo 'keys, OAuth tokens, and PGP keypairs.';
/bin/echo '';
/bin/echo 'Thank you for choosing Alabaster!';
/bin/echo '';
