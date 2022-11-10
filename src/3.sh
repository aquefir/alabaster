	| base64 -d | plzip -cd - | tar -xf -;
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
