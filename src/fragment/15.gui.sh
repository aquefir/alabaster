mkdir -p "$HOME/.config/terminator";
cp /etc/xdg/terminator/config "$HOME/.config/terminator/config";
mkdir -p /etc/skel/.config/terminator;
cp /etc/xdg/terminator/config /etc/skel/.config/terminator/config;
/bin/echo 'done.';

stdbuf -o0 /bin/echo -n 'Configuring file manager defaults... ';
mkdir -p /etc/xdg/Thunar;
