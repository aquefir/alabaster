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

.PHONY: default clean

default: alabaster.sh

clean:
	rm alabaster.sh

alabaster.sh:
	touch "$@"
	echo -n '' > "$@"
	cat src/1.sh >> "$@"
	echo -ne "\\t/bin/echo '" >> "$@"
	cat src/default.png | base64 | sed -z 's/\n//g' >> "$@"
	echo "' \\" >> "$@"
	cat src/2.sh >> "$@"
	echo -ne "\\t/bin/echo '" >> "$@"
	tarlz -9cn 512 -C src fumaca2 | base64 | sed -z 's/\n//g' >> "$@"
	echo "' \\" >> "$@"
	cat src/3.sh >> "$@"
	echo -ne "\\t/bin/echo '" >> "$@"
	cat src/settings.ini | plzip -c9n 512 | base64 | sed -z 's/\n//g' >> "$@"
	echo "' \\" >> "$@"
	cat src/4.sh >> "$@"
	echo -ne "\\t/bin/echo '" >> "$@"
	cat src/rc.xml | plzip -c9n 512 | base64 | sed -z 's/\n//g' >> "$@"
	echo "' \\" >> "$@"
	cat src/5.sh >> "$@"
	echo -ne "\\t/bin/echo '" >> "$@"
	cat src/menu.xml | plzip -c9n 512 | base64 | sed -z 's/\n//g' >> "$@"
	echo "' \\" >> "$@"
	cat src/6.sh >> "$@"
	echo -ne "\\t/bin/echo '" >> "$@"
	cat src/terminator.conf | plzip -c9n 512 | base64 | sed -z 's/\n//g' >> "$@"
	echo "' \\" >> "$@"
	cat src/7.sh >> "$@"
	echo -ne "\\t/bin/echo '" >> "$@"
	cat src/uca.xml | plzip -c9n 512 | base64 | sed -z 's/\n//g' >> "$@"
	echo "' \\" >> "$@"
	cat src/8.sh >> "$@"
	echo -ne "\\t/bin/echo '" >> "$@"
	cat src/tint2.conf | plzip -c9n 512 | base64 | sed -z 's/\n//g' >> "$@"
	echo "' \\" >> "$@"
	cat src/9.sh >> "$@"
