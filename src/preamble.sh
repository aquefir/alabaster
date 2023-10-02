#!/bin/sh
#
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
## Redistribution and use in source and binary forms are permitted,
## provided that ALL of the following conditions are met:
## 1. Derivative works of the source code cannot be distributed unless
##    express written consent to do so has been given by the copyright
##    holder(s); AND
## 2. Distributions in binary form must reproduce the above copyright
##    notice, this list of conditions and the following disclaimer in
##    the documentation and/or other materials provided with the
##    distribution.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
## FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
## COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
## INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
## (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
## SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
## HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
## STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
## ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
## OF THE POSSIBILITY OF SUCH DAMAGE.

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
stdbuf -o0 /bin/echo -n 'Getting bearings... ';
cd || exit 127; # start at home

# HACK: has to happen first and regardless, not ideal but w/e
mkdir -p /etc/sudoers.d;

/bin/echo 'done.';
