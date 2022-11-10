	| base64 -d > /usr/share/wallpapers/default.png
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
