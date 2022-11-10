	| base64 -d | plzip -dc - > /etc/gtk-2.0/settings.ini;
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
