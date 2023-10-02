
if uname -a | grep -q '.el'; then

# It is RHEL, but is it the right version?
if uname -a | grep -q '.el7.'; then
: # pass
elif uname -a | grep -q '.el8.'; then
: # pass
elif uname -a | grep -q '.el9.'; then
: # pass
else

/bin/echo 'Your version of RHEL is either too old or too new.';
/bin/echo 'Alabaster supports RHEL 7, 8, and 9. Exiting...';
exit 127;

fi

stdbuf -o0 /bin/echo -n 'Installing the EPEL... ';

if uname -a | grep -q '.el7.'; then
rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 1>/dev/null 2>&1;
yum update 1>/dev/null 2>&1;
yum install epel-release 1>/dev/null 2>&1;
elif uname -a | grep -q '.el8.'; then
rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm 1>/dev/null 2>&1;
yum update 1>/dev/null 2>&1;
dnf config-manager --set-enabled crb 1>/dev/null 2>&1;
dnf install epel-release 1>/dev/null 2>&1;
elif uname -a | grep -q '.el9.'; then
rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm 1>/dev/null 2>&1;
dnf config-manager --set-enabled crb 1>/dev/null 2>&1;
dnf install epel-release 1>/dev/null 2>&1;
fi

stdbuf -o0 /bin/echo -n 'Installing dependencies with yum... ';

yum install -y \
    wget autoconf automake binutils bison flex gcc gcc-c++ \
    gettext libtool make patch pkgconfig emacs-nox curl-devel \
    expat-devel gettext-devel openssl-devel zlib-devel perl-CPAN \
    perl-devel zip unzip xz p7zip lzop arj bzip2 gzip ncompress zstd \
    1>/dev/null 2>&1;

/bin/echo 'done.';

fi
