# About Ydfs

(Your Distro From Scratch) is a tool to build your own linux distribution 

# Build ydfs ISO

(from docker, Linux terminal or Windows powershell)

* mkdir iso
* chmod 777 iso

## Automatic 64 bits ISO Build

* docker run --name ydfs3 -d --mount type=bind,source="$(pwd)"/iso,target=/home/linuxconsole2020/iso -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  yledoare/ydfs3 
* docker logs --tail=10 -f ydfs3
* docker logs -f ydfs3 2>&1 |grep build

## Verbose Build, without sharing output ISO on host :

* docker run --name linuxconsole3 -e DIBAB_VERBOSE_BUILD=YES yledoare/ydfs3

# Manual build

* docker run -d --name ydfs3 yledoare/ydfs3 tail -f /dev/null 
* docker exec -ti ydfs2 bash
* cd $HOME
* git clone https://bitbucket.org/yourdistrofromscratch/ydfs.git
* cd ydfs
* cd 3.0
* make 

# Custom build

See inside "config.ini" (written when selected ARCH)
