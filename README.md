# Alabaster Linux

**One liner:**

```wget -O- -UwUget alabaster.sh | sh```

**Alternative syntax for RHEL-based distros:**

```curl -fsSL alabaster.sh | sh```

Installing and using `wget` will not work on RHELs as their version apparently does not follow redirects.

## GUI setup

1. Download a compatible GNU/Linux distro:
	- Debian 10 (`buster`)
	- Debian 11 (`bullseye`)
	- Debian 12 (`bookworm`)
	- Arch Linux
2. Boot into it and install it
3. Follow setup according to your desires, _but:_ on Debian, deselect all apt packages except for "standard system utilities". **Do NOT install a desktop environment!**
4. Log in as root using the password you set during installation.
5. Run the one-liner up top!
6. Once it completes, run reboot and log in normally.

## CLI setup

1. Download a compatible GNU/Linux distro:
	- CentOS 7
	- Rocky Linux 8
	- Rocky Linux 9
	- AlmaLinux 8
	- AlmaLinux 9
	- Debian 10 (`buster`)
	- Debian 11 (`bullseye`)
	- Debian 12 (`bookworm`)
	- Arch Linux
2. Boot into it and install it
3. Follow setup according to your desires, _but:_ on Debian, deselect all apt packages except for "standard system utilities". 4. **Do NOT install a desktop environment!**
4. Log in as root using the password you set during installation.
5. Run the one-liner up top!
6. Once it completes, run reboot and log in normally.

## Why?

It is helpful to have a curated software environment that provides consistent behaviour across space and time. To this end, Alabaster Linux is a 'pseudo-distro' that sets up using a suite of scripts on top of a clean installation of an established distribution of GNU/Linux.

Developing and maintaining Alabaster as a 'proper' Linux distribution is more work and has other practical downsides; for example, ISOs would have to be made, and specific accomodations would need to be made for various architectures. Our approach lets us ignore all of that stuff and just set up Debian as it comes, be it on AMD64, AArch64, RISC-V, or whatever Debian supports. We only need to make sure the software we author works across these support targets, which is part of why Alabaster is needed!

## Further information

If there are other distros that you use which aren't listed here, and you would like to contribute an equivalent package list to save time for others, please reach out by emailing postmaster at this domain.

Fumaca 2 is the Openbox window theme in use. SkeuOS (grey, dark) is the GTK+ UI theme. Papirus Dark is the icon theme, and Breeze Snow is the cursor theme.

Originally, Alabaster only targeted Debian 10 (`buster`) and CentOS 7, but has since added support for Debian 11 (`bullseye`) and 12 (`bookworm`), Rocky Linux and AlmaLinux versions 8 and 9 (community continuations of CentOS), and Arch Linux in rolling release. It also began with Debian being fixed to GUI distribution and CentOS to CLI distribution, however this is now user-selectable – you can choose either GUI or CLI for Debian and Arch Linux based setups (RHEL-based is still CLI only).

## Licencing

The Alabaster install script from `alabaster.sh` is licenced under the [Artisan Software Licence, version 1.1](https://aquefir.co/asl). The contents it installs are licenced under their respective licences; consult the contents of the installation script and the source code repository to find out which projects are brought in and what their licences are.
