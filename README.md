# Original README

What:

Flashybrid is a system to help in setting up and managing hybrid
flash/disk/ram based Debian systems which can run most of the time
using only a small flash disk for their root filesystem and do a useful,
but limited task (such as being a router, or a PDA, or a rescue system
on a USB keydrive). The flash can be as small as 32 mb, though 64 to 256
is more comfortable.

Flashybrid needs rsync, and the 2.4 or greater linux kernel with tmpfs
support built in.

Why:

I developed this system for my little OpenBrick computer, which I use as a
wireless access point / dialup firewall most of the time, in fairly extreme
environmental conditions where I do not want a hard disk to be running, but
which I occasionally use for long overnight downloads, or hook up a monitor
and use as a desktop machine, and which I want to be able to manage as a
regular Debian system for easy access to upgrades and security fixes. My
OpenBrick originally had 32 mb of flash, 128 mb of ram, and a 1 gb hard
disk, and now sports 256 mb of flash and 10 gb of disk.

How:

A flashybrid system boots from its flash, and has all the necessary
libraries and programs on the flash to bring up whatever daemons are
needed for it to perform its embedded functions. 

Care is taken to keep the flash mounted read-only to prevent excessive
writes to the flash which could wear it out. Directories such as /var/log
which need to be writable are stored on a ram disk, and have their
contents stored back to the flash on reboot.

Who:

Flashybrid was created by Joey Hess <joey@kitenet.net>

When:

I originally wrote flashybrid in 2002, and used it successfully for a year
with a embedded Debian system with only 32 mb of flash. Then I bought a
much larger 256 mb flash, and armed with a year's experience and less
I rewrote flashybrid to make it easier to install, more robust, and finally
released it to the public in fall 2003.

Prolog:
This version of flashybrid is modified a lot from what Joey released as 0.02. 
I felt that many parts of the system were not really maintained, and eventually
I dropped them. The new version is way smaller, and hopefully more robust. It's
actively maintained, which IMHO is much more important.

Diego Iastrubni <diego.iastrubni@xorcom.com>


# Xnext

## Ubuntu 20.04: few notes

We provided a wrapper service, not elegant yet working. Look for delay-mountro files.
THIS HAS TO BE INSTALLED MANUALLY

It seems to work without a swap file (/swap.img) and with a fstab without UUID and proper options. Example

> /dev/sda2           /    ext4  errors=remount-ro      0    1

NR says the UUID part is not relevant

Further, we [removed](https://www.kevin-custer.com/blog/disabling-snaps-in-ubuntu-20-04/) completely the Snap system

Remember to manually create the `/ram` directory!!!!!!!!!

Patrizio Bertoni <pbertoni@x-next.com>
Nevio Rebesco <nrebesco@x-next.com>

## Istruzioni

Per abilitare flashybrid in /etc/default/flashybrid

    ENABLED=yes

In /etc/flashybrid ci sono i file di configurazione (caricati qua nel nostro repo forked) :

  * config
  * ramstore
  * ramtmp

Per invece disabilitarlo se gia' attivo:
 
  1. Montare in scrittura con `/sbin/mountrw`
  2. modificare il suddetto ENABLED
  3. Rimontare il lettura `/sbin/mountro`
