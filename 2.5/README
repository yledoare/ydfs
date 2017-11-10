Ydfs (Your Distro From Scratch) is a tool to build a linux distribution 

Features :

* Buildt from user account (no root or sudo needed)
* Fast boot
* Support x86, x86_64 (and maybe arm ARCH)
* applications must be buildt from source

#Build ydfs ISO

Your Distro From Scratch 2.* is buildt from Debian8 (x86 and x86_64), you will need recent building tools to make it successfull

# Install debootstrap for 32 bit release 

You can build 32 and 64 bit on one computer

```
#!shell
MY_CHROOT=/home/debian-jessie-32

install -d $MY_CHROOT
debootstrap --arch i386 jessie $MY_CHROOT http://http.debian.net/debian/
echo "proc $MY_CHROOT/proc proc defaults 0 0" >> /etc/fstab
mount proc $MY_CHROOT/proc -t proc
echo "sysfs $MY_CHROOT/sys sysfs defaults 0 0" >> /etc/fstab
mount sysfs $MY_CHROOT/sys -t sysfs
cp /etc/hosts $MY_CHROOT/etc/hosts
cp /proc/mounts $MY_CHROOT/etc/mtab
chroot $MY_CHROOT /bin/bash
```

#Install debian toolchain packages

```
#!shell

wget --no-check-certificate https://bitbucket.org/yourdistrofromscratch/ydfs/raw/master/2.5/configure
sh configure
```

#Add user
```
#!shell
useradd linuxconsole
mkdir /home/linuxconsole
chown linuxconsole /home/linuxconsole
```

#Log in as user
```
#!shell
su - linuxconsole
cd $HOME
install -d src
cd src
git clone https://bitbucket.org/yourdistrofromscratch/ydfs.git
cd ydfs
cd 2.5
make 
```

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

# Add locales

* sudo vim /var/lib/locales/supported.d/local (ubuntu)
* sudo vim /etc/locale.gen (debian)

br_FR.UTF-8 UTF-8
de_DE.UTF-8 UTF-8
en_US.UTF-8 UTF-8
es_ES.UTF-8 UTF-8
fr_CA.UTF-8 UTF-8
fr_FR.UTF-8 UTF-8
pt_BR.UTF-8 UTF-8
ru_RU.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
cs_CZ.UTF-8 UTF-8
pl_PL.UTF-8 UTF-8

* sudo dpkg-reconfigure locales
* or locale-gen
