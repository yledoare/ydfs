Ydfs (Your Distro From Scratch) is a tool to build a linux distribution 

Features :

* Buildt from user account (no root or sudo needed)
* Fast boot
* Support x86, x86_64 (and maybe arm ARCH)
* applications must be buildt from source

#Build ydfs ISO

mkdir ydfs

Automatic :

* docker pull yledoare/ydfs
* docker run --mount type=bind,source="$(pwd)"/ydfs,target=/home/linuxconsole2019/ydfs  yledoare/ydfs

Manual :

* docker run yledoare/ydfs bash
* git clone https://bitbucket.org/yourdistrofromscratch/ydfs.git
* cd ydfs
* cd 2.7
* make 


# Build process 
* Select arch to build
* all packages form packages/list-$ARCH are downloaded then build
* kernel is build
* modules and iso are created
* you can run "make test"

# Custom build

See inside "config.ini" (written when selected ARCH)

You can :

  * Use crosstool-ng instead of host toolchain
  * build your own toolchain
  * enable MENUCONFIG=YES to select your kernel options

# Install debootstrap for 32 bit release 
You can build 32 and 64 bit on one computer

```
#!shell
MY_CHROOT=/home/debian-buster-32
apt-get install debootstrap
install -d $MY_CHROOT
debootstrap --arch i386 buster $MY_CHROOT http://http.debian.net/debian/
echo "proc $MY_CHROOT/proc proc defaults 0 0" >> /etc/fstab
mount proc $MY_CHROOT/proc -t proc
echo "sysfs $MY_CHROOT/sys sysfs defaults 0 0" >> /etc/fstab
mount sysfs $MY_CHROOT/sys -t sysfs
cp /etc/hosts $MY_CHROOT/etc/hosts
cp /proc/mounts $MY_CHROOT/etc/mtab
chroot $MY_CHROOT /bin/bash
```
