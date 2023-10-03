#!/usr/bin/env make
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

.PHONY: all clean

all: alabaster.sh cli.alabaster.sh gui.alabaster.sh

clean:
	$(RM) alabaster.sh
	$(RM) cli.alabaster.sh
	$(RM) gui.alabaster.sh
	$(RM) src/*.part
	$(RM) src/*.tar*

alabaster.sh: src/preamble.sh src/checkdua.sh src/lzlib.part src/plzip.part src/tarlz.part src/initrhel.sh src/sudo-nopasswd.conf.part src/getdots.part src/undots.part src/post.sh
cli.alabaster.sh: src/preamble.sh src/checkcli.sh src/initrhel.sh src/lzlib.part src/plzip.part src/tarlz.part src/sudo-nopasswd.conf.part src/getdots.part src/undots.part src/post.sh
gui.alabaster.sh: src/preamble.sh src/checkgui.sh src/lzlib.part src/plzip.part src/tarlz.part src/sudo-nopasswd.conf.part src/mkdirs.sh src/getdots.part src/default.png.part src/scite.conf.part src/uca.xml.part src/menu.xml.part src/rc.xml.part src/fdorg.xml.part src/gtk.ini.part src/profiles.ini.part src/term.conf.part src/tint2.conf.part src/index.theme.part src/ldmgreet.conf.part src/lightdm.conf.part src/autostart.conf.part src/user-dirs.conf.part src/getarcs.part src/fumaca2.part src/palemoon.part src/undots.part src/unarcs.part src/postgui.sh src/post.sh

alabaster.sh cli.alabaster.sh gui.alabaster.sh:
	cat $+ > $@;

src/default.png.part: src/default.png
	util/mkmbed.sh $< /usr/share/wallpapers/default.png $@

src/scite.conf.part: src/scite.conf
	util/mkmbed.sh $< /usr/share/scite/SciTEGlobal.properties $@

src/uca.xml.part: src/uca.xml
	util/mkmbed.sh $< /etc/xdg/Thunar/uca.xml $@

src/menu.xml.part: src/menu.xml
	util/mkmbed.sh $< /etc/xdg/openbox/menu.xml $@

src/rc.xml.part: src/rc.xml
	util/mkmbed.sh $< /etc/xdg/openbox/rc.xml $@

src/fdorg.xml.part: src/fdorg.xml
	util/mkmbed.sh $< /usr/share/mime/packages/freedesktop.org.xml $@

src/gtk.ini.part: src/gtk.ini
	util/mkmbed.sh $< /etc/gtk-2.0/gtk.ini $@

src/profiles.ini.part: src/profiles.ini
	util/mkmbed.sh $< '/etc/skel/.moonchild productions/pale moon/profiles.ini' $@

src/term.conf.part: src/term.conf
	util/mkmbed.sh $< /etc/xdg/terminator/config $@

src/tint2.conf.part: src/tint2.conf
	util/mkmbed.sh $< /etc/xdg/tint2/tint2rc $@

src/index.theme.part: src/index.theme
	util/mkmbed.sh $< /usr/share/icons/default/index.theme $@

src/ldmgreet.conf.part: src/ldmgreet.conf
	util/mkmbed.sh $< /etc/lightdm/lightdm-gtk-greeter.conf $@

src/lightdm.conf.part: src/lightdm.conf
	util/mkmbed.sh $< /etc/lightdm/lightdm.conf $@

src/01-bg.conf.part: src/01-bg.conf
	util/mkmbed.sh $< /etc/dconf/db/local.d/01-background $@

src/autostart.conf.part: src/autostart.conf
	util/mkmbed.sh $< /etc/xdg/openbox/autostart $@

src/sudo-nopasswd.conf.part: src/sudo-nopasswd.conf
	util/mkmbed.sh $< /etc/sudoers.d/sudo-nopasswd $@

src/user-dirs.conf.part: src/user-dirs.conf
	util/mkmbed.sh $< /etc/xdg/user-dirs.conf $@

src/lzlib.part:
	util/mkcomp.py lzlib https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.13.tar.gz gz > $@;

src/plzip.part:
	util/mkcomp.py plzip https://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.10.tar.gz gz > $@;

src/tarlz.part:
	util/mkcomp.py tarlz https://download.savannah.gnu.org/releases/lzip/tarlz/tarlz-0.23.tar.lz lz > $@;

src/getdots.part:
	/bin/echo '' > $@;
	util/mkget.py 'Alabaster dotfiles' https://github.com/aquefir/dotfiles/archive/refs/heads/master.tar.gz /tmp/dotfiles.tar.gz >> $@;

src/undots.part:
	/bin/echo '' > $@;
	util/mkuntar.py 'Alabaster dotfiles' /tmp/dotfiles.tar.gz /tmp >> $@;
	/bin/echo 'mv /tmp/dotfiles-* /tmp/dotfiles-repo;' >> $@;
	/bin/echo 'sh /tmp/dotfiles-repo/util/tarball.sh /tmp/dotfiles-repo/src /tmp/out.tar;' >> $@;
	/bin/echo 'tar -xf /tmp/out.tar -C /etc/skel;' >> $@;
	/bin/echo 'rm -rf /tmp/dotfiles-repo;' >> $@;

src/getarcs.part:
	/bin/echo '' > $@;
	util/mkget.py 'Source Sans Pro' https://github.com/adobe-fonts/source-sans/releases/download/3.046R/TTF-source-sans-3.046R.zip /tmp/source-sans-pro.zip >> $@;
	util/mkget.py 'Source Serif Pro' https://github.com/adobe-fonts/source-serif/releases/download/4.004R/source-serif-4.004.zip /tmp/source-serif-pro.zip >> $@;
	util/mkget.py 'Source Code Pro' https://github.com/adobe-fonts/source-code-pro/releases/download/2.038R-ro%2F1.058R-it%2F1.018R-VAR/TTF-source-code-pro-2.038R-ro-1.058R-it.zip /tmp/source-code-pro.zip >> $@;
	util/mkget.py 'Source Han Sans' https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSans.ttc.zip /tmp/source-han-sans.zip >> $@;
	util/mkget.py 'Source Han Serif' https://github.com/adobe-fonts/source-han-serif/releases/download/2.001R/01_SourceHanSerif.ttc.zip /tmp/source-han-serif.zip >> $@;
	util/mkget.py 'Source Han Mono' https://github.com/adobe-fonts/source-han-mono/releases/download/1.002/SourceHanMono.ttc /usr/local/share/fonts/alabaster/SourceHanMono.ttc >> $@;
	util/mkget.py 'SkeuOS GTK+ theme' https://github.com/daniruiz/skeuos-gtk/archive/refs/tags/20220629.tar.gz /tmp/skeuos.tar.gz >> $@;
	util/mkget.py 'Breeze Snow cursor theme' https://code.jpope.org/jpope/breeze_cursor_sources/raw/master/breeze-snow-cursor-theme.zip /tmp/breeze-snow.zip >> $@;
	util/mkget.py 'Papirus icon theme' https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/archive/refs/tags/20220910.tar.gz /tmp/papirus-icon-theme.tar.gz >> $@;

src/unarcs.part:
	/bin/echo '' > $@;
	util/mkunzip.py 'Source Sans Pro' /tmp/source-sans-pro.zip /usr/local/share/fonts/alabaster/ >> $@;
	util/mkunzip.py 'Source Serif Pro' /tmp/source-serif-pro.zip /usr/local/share/fonts/alabaster/ >> $@;
	util/mkunzip.py 'Source Code Pro' /tmp/source-code-pro.zip /usr/local/share/fonts/alabaster/ >> $@;
	util/mkunzip.py 'Source Han Sans' /tmp/source-han-sans.zip /usr/local/share/fonts/alabaster/ >> $@;
	util/mkunzip.py 'Source Han Serif' /tmp/source-han-serif.zip /usr/local/share/fonts/alabaster/ >> $@;
	util/mkunzip.py 'Breeze Snow cursor theme' /tmp/breeze-snow.zip /usr/share/icons >> $@;
	util/mkuntar.py 'SkeuOS GTK+ theme' /tmp/skeuos.tar.gz /tmp >> $@;
	util/mkuntar.py 'Papirus icon theme' /tmp/papirus-icon-theme.tar.gz /usr/share/icons >> $@;

src/fumaca2.tar.lz:
	tarlz -c9n 8 -C src -f $@ fumaca2/;

src/palemoon.tar.lz:
	tarlz -c9n 8 -C src -f $@ defacto/;

src/fumaca2.part: src/fumaca2.tar.lz
src/palemoon.part: src/palemoon.tar.lz

src/fumaca2.part:
	/bin/echo -n "echo " > $@
	base64 $< | sed -z 's/\n//g' >> $@
	/bin/echo " | base64 -d | plzip -cd - | tar -xf - -C /usr/share/themes;" >> $@;

src/palemoon.part:
	/bin/echo -n "echo " > $@
	base64 $< | sed -z 's/\n//g' >> $@
	/bin/echo " | base64 -d | plzip -cd - | tar -xf - -C '/etc/skel/.moonchild productions/pale moon';" >> $@;
