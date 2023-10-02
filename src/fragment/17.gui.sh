mkdir -p "$HOME/.config/tint2";
cp /etc/xdg/tint2/tint2rc "$HOME/.config/tint2/tint2rc";
mkdir -p /etc/skel/.config/tint2;
cp /etc/xdg/tint2/tint2rc /etc/skel/.config/tint2/tint2rc;
cwd="$PWD";
cd /usr/share/applications;
ln -sf Thunar.desktop thunar.desktop;
cd "$cwd";
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Configuring XDG defaults... ';
stdbuf -o0 /bin/echo -n '' > /etc/xdg/user-dirs.defaults;
/bin/echo -e 'enabled=False\nfilename_encoding=UTF-8' > /etc/xdg/user-dirs.conf;
/bin/echo 'done.';
