# Alabaster Linux

*A chalky, robust Debian pseudo-distro.*

**TL;DR copypasta**

```sh
wget -O- -UwUget alabaster.sh | sh
```

## Introduction

It is helpful to have a curated software environment that provides consistent behaviour across space and time. To this end, Alabaster Linux is a ‘pseudo-distro’ that sets up using a suite of scripts on top of a clean installation of the stable version of Debian (currently `bullseye`).

### Background

Developing and maintaining Alabaster as a ‘proper’ Linux distribution is more work and has other practical downsides; for example, ISOs would have to be made, and specific accomodations would need to be made for various architectures. Our approach lets us ignore all of that stuff and just set up Debian as it comes, be it on AMD64, AArch64, RISC-V, or whatever Debian supports. We only need to make sure the software we author works across these support targets, which is part of why Alabaster is needed!

## Setup

1. Download [Debian `netinst` ISO](https://www.debian.org/distrib/netinst) file.
2. Boot into it and select `Install` (**not** `Graphical install`!)
3. Follow setup according to your desires, but **deselect all apt packages except for `standard system utilities`!**
4. **MAKE SURE YOU FOLLOW STEP 3 PRECISELY!**
5. Log in as `root` using the password you set during installation.
6. Run this command: `wget -O- -UwUget alabaster.sh | sh`
7. Once it completes, run `reboot` and log in as normal with your regular account.

You should find yourself on a blank desktop. Three programs are available to you, both from the top left corner in the tintray, as well as by right-clicking anywhere on the desktop: a terminal, a file manager, and a command runner.

The rest is left up to you. Good luck soldier.
