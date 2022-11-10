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
