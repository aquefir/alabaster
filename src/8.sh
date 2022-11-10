	| base64 -d | plzip -dc > /etc/xdg/Thunar/uca.xml;
	mkdir -p "$HOME/.config/Thunar";
	cp /etc/xdg/Thunar/uca.xml "$HOME/.config/Thunar/uca.xml";
	mkdir -p /etc/skel/.config/Thunar;
	cp /etc/xdg/Thunar/uca.xml /etc/skel/.config/Thunar/uca.xml;
	/bin/echo 'done.';
	## this file is "tint2rc.gz" in base64
	/bin/echo -n 'Configuring tint2 defaults... ';
	mkdir -p /etc/xdg/tint2;
