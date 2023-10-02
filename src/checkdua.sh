if uname -a | grep -q '.el'; then

# pass. initrhel shows up later to execute unconditionally

else

/bin/echo 'You have grepped the bare alabaster.sh endpoint.';
/bin/echo '';
/bin/echo 'Alabaster now supports more distros, but it cannot';
/bin/echo 'Distinguish whether you want a graphical or text-only';
/bin/echo 'installation without losing its non-interactive one-liner';
/bin/echo 'installation approach.';
/bin/echo '';
/bin/echo 'Only RHEL-based distros will work from here since they';
/bin/echo 'lack GUI support from us anyway.';
/bin/echo '';
/bin/echo 'To remedy this, modify your one-liner to add either "cli"';
/bin/echo 'or "gui" as a subdomain, so that';
/bin/echo '';
/bin/echo '    wget -O- -UwUget alabaster.sh | sh';
/bin/echo '';
/bin/echo 'becomes';
/bin/echo '';
/bin/echo '    wget -O- -UwUget cli.alabaster.sh | sh';
/bin/echo 'or';
/bin/echo '    wget -O- -UwUget gui.alabaster.sh | sh';
/bin/echo '';
/bin/echo 'as desired.';
/bin/echo '';
/bin/echo 'Thank you for choosing Alabaster!';
/bin/echo '';

fi
