mkdir -p "$HOME/.config/openbox";
cp /etc/xdg/openbox/rc.xml "$HOME/.config/openbox/rc.xml";
cp /etc/xdg/openbox/menu.xml "$HOME/.config/openbox/menu.xml";
mkdir -p /etc/skel/.config/openbox;
cp /etc/xdg/openbox/rc.xml /etc/skel/.config/openbox/rc.xml;
cp /etc/xdg/openbox/menu.xml /etc/skel/.config/openbox/menu.xml;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Configuring terminal defaults... ';
mkdir -p /etc/xdg/terminator;
