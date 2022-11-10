	| base64 -d | plzip -dc - > /etc/xdg/tint2/tint2rc;
	mkdir -p "$HOME/.config/tint2";
	cp /etc/xdg/tint2/tint2rc "$HOME/.config/tint2/tint2rc";
	mkdir -p /etc/skel/.config/tint2;
	cp /etc/xdg/tint2/tint2rc /etc/skel/.config/tint2/tint2rc;
	cwd="$PWD";
	cd /usr/share/applications;
	ln -sf Thunar.desktop thunar.desktop;
	cd "$cwd";
	/bin/echo 'done.';
	/bin/echo -n 'Configuring XDG defaults... ';
	/bin/echo -n '' > /etc/xdg/user-dirs.defaults;
	/bin/echo -e 'enabled=False\nfilename_encoding=UTF-8' > /etc/xdg/user-dirs.conf;
	/bin/echo 'done.';
fi

cd; # go home

/bin/echo -n 'Configuring sudoers defaults... ';
mkdir -p /etc/sudoers.d;
/bin/echo -e '%sudo\tALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/sudo-nopasswd;
/bin/echo 'done.';
/bin/echo -n 'Downloading dotfiles... ';
curl -fsSL 'https://github.com/aquefir/dotfiles/archive/refs/heads/master.tar.gz' > dotfiles.tar.gz;
/bin/echo 'done.';
tar -xf dotfiles.tar.gz;
cd dotfiles-* || exit 127;
sh util/tarball.sh src "/tmp/out.tar";
/bin/echo -n 'Installing the dotfiles into /etc/skel... ';
cd /etc/skel || exit 127;
tar -xf "/tmp/out.tar";
/bin/echo 'done.';
/bin/echo -n 'Installing the dotfiles into /root... ';
cd /root || exit 127;
tar -xf "/tmp/out.tar";
/bin/echo 'done.';
/bin/echo -n 'Installing the dotfiles into /home subdirectories... ';
for dir in $(ls -A1 /home); do
	/bin/echo -n "/home/$dir... ";
	cp -r /etc/skel/. "/home/$dir/";
	chown -R "$dir":"$dir" "/home/$dir";
done
cp /etc/skel/.gitconfig /etc/gitconfig;
/bin/echo 'done.';
/bin/echo -n 'Cleaning up dotfiles staging... ';
cd; # go home
rm -rf dotfiles-* dotfiles.tar.gz /tmp/out.tar;
/bin/echo 'done.'

/bin/echo '';
/bin/echo 'Setup is now complete.';
/bin/echo '';
/bin/echo 'You may now reboot into your new installation!';
/bin/echo '';
/bin/echo 'Before leaving, you may wish to create additional users; if any of';
/bin/echo 'them need sudo privileges, the system is already configured to';
/bin/echo 'give it to all members of the sudo usergroup (usermod -aG sudo).';
/bin/echo '';
/bin/echo 'This is also a good time to install any credentials, such as SSH';
/bin/echo 'keys, OAuth tokens, and PGP keypairs.';
/bin/echo '';
/bin/echo 'Thank you for choosing Alabaster!';
/bin/echo '';
