stdbuf -o0 /bin/echo -n 'Installing the dotfiles into /home subdirectories... ';
for dir in $(ls -A1 /home); do
	/bin/echo -n "/home/$dir... ";
	cp -r /etc/skel/. "/home/$dir/";
	chown -R "$dir":"$dir" "/home/$dir";
done
cp /etc/skel/.gitconfig /etc/gitconfig;
/bin/echo 'done.';


/bin/echo '';
/bin/echo 'Setup is now complete.';
/bin/echo '';
/bin/echo 'You may now reboot into your new installation!';
/bin/echo '';
/bin/echo 'Before leaving, you may wish to create additional users;';
/bin/echo 'if any of them need sudo privileges, the system is already';
/bin/echo 'configured to give it to all members of the sudo usergroup';
/bin/echo '(usermod -aG sudo).';
/bin/echo '';
/bin/echo 'This is also a good time to install any credentials,';
/bin/echo 'such as SSH keys, OAuth tokens, and PGP keypairs.';
/bin/echo '';
/bin/echo 'Thank you for choosing Alabaster!';
/bin/echo '';
