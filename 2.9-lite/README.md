# About Ydfs

(Your Distro From Scratch) is a tool to build your own linux distribution 

# Gest last stable

* git clone https://bitbucket.org/yourdistrofromscratch/ydfs.git
* cd ydfs
* cd 2.9-lite

# Build docker images

## 64 bits
docker build -f Dockerfile -t ydfs64-2.9-lite .

## 32 bits
docker build -f Dockerfile32 -t ydfs32-2.9-lite .

# Build ydfs ISO

* mkdir $HOME/iso
* chmod 777 $HOME/iso

## Automatic full 64 bits ISO Build

* docker run --name ydfs64-2.9-lite -d --mount type=bind,source="$HOME"/iso,target=/home/linuxconsole2022/iso ydfs64-2.9-lite

## Force distro name

* docker run --name ydfs64-2.9-lite -e DISTRONAME=gamejam -d --mount type=bind,source="$HOME"/iso,target=/home/linuxconsole2022/iso ydfs64-2.9-lite
