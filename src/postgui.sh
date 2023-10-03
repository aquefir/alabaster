mv /tmp/skeuos-* /tmp/skeuos-repo;
cp -r /tmp/skeuos-repo/themes/Skeuos-Grey-Dark /usr/share/themes/skeuos-grey-dark;
cp -r /tmp/skeuos-repo/themes/Skeuos-Grey-Dark-GNOME_40+41/gnome-shell /usr/share/themes/skeuos-grey-dark/gnome-shell;
cp -r /tmp/skeuos-repo/themes/Skeuos-Grey-Dark-FullPanel-GNOME_40+41 /usr/share/themes/skeuos-grey-dark-fullpanel;
rm -rf /tmp/skeuos-repo skeuos.tar.gz;
test -d /usr/share/icons/breeze-snow && rm -rf /usr/share/icons/breeze-snow;
mv /usr/share/icons/Breeze_Snow /usr/share/icons/breeze-snow;
mv /usr/share/icons/papirus-* /usr/share/icons/papirus-repo;
test -d /usr/share/icons/papirus && rm -rf /usr/share/icons/papirus;
mv /usr/share/icons/papirus-repo/Papirus /usr/share/icons/papirus;
rm -rf /usr/share/icons/papirus-repo;
cp /etc/gtk-2.0/settings.ini /etc/gtk-3.0/settings.ini
cp /etc/gtk-2.0/settings.ini /etc/skel/.config/gtk-3.0/settings.ini
update-mime-database /usr/share/mime;
