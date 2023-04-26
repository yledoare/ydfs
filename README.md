# About Ydfs

(Your Distro From Scratch) is a tool to build your own linux distribution 

# Gest last stable

* git clone https://github.com/yledoare/ydfs.git
* cd ydfs
* git checkout v2.9.6
* cd 2.9

# Build docker images

## 64 bits
docker build -f Dockerfile -t ydfs64-2.9 .

## 32 bits
docker build -f Dockerfile32 -t ydfs32-2.9 .

# Build ydfs ISO

* mkdir $HOME/iso
* chmod 777 $HOME/iso

## Automatic full 64 bits ISO Build

* docker run --name ydfs64-2.9 -d --mount type=bind,source="$HOME"/iso,target=/home/linuxconsole2023/iso ydfs64-2.9 
* docker logs --tail=10 -f ydfs64-2.9
* docker logs -f ydfs64-2.9 2>&1 |grep build

## Automatic full 32 bits ISO Build

* docker run --name ydfs32-2.9 -d --mount type=bind,source="$HOME"/iso,target=/home/linuxconsole2023/iso  ydfs32-2.9
* docker logs --tail=10 -f ydfs32-2.9

## Fast 64 bits ISO

* docker run --name ydfs64-2.9-fast -e BUILDYDFS=fast -d --mount type=bind,source="$HOME"/iso,target=/home/linuxconsole2023/iso  ydfs64-2.9

## Fast 32 bits ISO

* docker run --name ydfs32-2.9-fast -e BUILDYDFS=fast -d --mount type=bind,source="$HOME"/iso,target=/home/linuxconsole2023/iso  ydfs32-2.9

## Write ISO to USB key

* dd if=iso/linuxconsole.iso of=/dev/sdf bs=4M status=progress oflag=sync

## Build and test

* xhost +
* docker run --name ydfs-test -d --mount type=bind,source="$HOME"/iso,target=/home/linuxconsole2023/iso -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  ydfs64-2.9 
* docker exec -ti ydfs-test c 'cd $HOME/src/ydfs/2.9 ; make live-test'

## Verbose Build, without sharing output ISO on host :

* docker run --name linuxconsole2023 -e DIBAB_VERBOSE_BUILD=YES ydfs64-2.9

# Manual build (64 bits)

* docker run -d --name ydfs ydfs64-2.9 tail -f /dev/null 
* docker exec -ti ydfs bash
* cd $HOME
* git clone https://github.com/yledoare/ydfs.git
* cd ydfs
* cd 2.9
* make 

# Build from WSL2 (Ubunut bullseye / 64 bits)

grep RUN Dockerfile | sed s'/RUN//' > install.sh
bash install.sh
useradd -m linuxconsole2023
su - linuxconsole2023 $PWD/build-lc2023

# Troubleshooting :

Error when build QT ?
Add "--security-opt seccomp:unconfined" option on Debian Strech
https://stackoverflow.com/questions/52705124/why-qdirexists-do-not-work-in-docker-container

# Features 

* Buildt from user account (no root or sudo needed)
* Fast boot
* Support x86, x86_64 ( arm not tested )
* applications are buildt from source

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
