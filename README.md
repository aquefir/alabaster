# Alabaster Linux

*A chalky, robust Debian pseudo-distro.*

-----

It is helpful to have a curated software environment that provides consistent behaviour across space and time. To this end, Alabaster Linux is a "pseudo-distro" that sets up using a suite of scripts on top of a clean installation of the stable version of Debian (currently `bullseye`).

Developing and maintaining Alabaster as a "proper" Linux distribution is more work and has other practical downsides; for example, ISOs would have to be made, and specific accomodations would need to be made for various architectures. Our approach lets us ignore all of that stuff and just set up Debian as it comes, be it on AMD64, AArch64, RISC-V, or whatever Debian supports. We only need to make sure the software we author works across these support targets, which is part of why Alabaster is needed!
