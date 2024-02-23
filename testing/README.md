# About Ydfs

(Your Distro From Scratch) is a tool to build your own linux distribution 

# Build docker images
docker build -f Dockerfile -t ydfs3 .

# Build ydfs ISO

docker run -ti --rm --security-opt seccomp=unconfined -w="$(pwd)" -v "$(pwd):$(pwd)" --user="ydfs3:`id -g`" ydfs3 /bin/bash /home/ydfs3/build

## END


docker run -ti --rm --security-opt seccomp=unconfined \
	-w="$(pwd)" \
	-v "$(pwd):$(pwd)" \
	-v "${PWD}/dl:/share/dl" \
	-v "${PWD}/host:/share/host" \
	--user="`id -u`:`id -g`" \
	ydfs3 bash

# docker run -ti --rm --security-opt seccomp=unconfined -w="$(pwd)" -v "$(pwd):$(pwd)" --user="ydfs3:`id -g`" ydfs3 bash /home/ydfs3/build
# docker run -ti --rm --security-opt seccomp=unconfined -w="$(pwd)" -v "$(pwd):$(pwd)" -v "${PWD}/tarballs:/home/ydfs3/ydfs/tarballs" -v "${PWD}/host:/share/host" --user="ydfs3:`id -g`" ydfs3 bash

(from docker, Linux terminal or Windows powershell)

* mkdir iso
* chmod 777 iso

## Automatic 64 bits ISO Build

* docker run --name ydfs3 -d --mount type=bind,source="$(pwd)"/iso,target=/home/linuxconsole2020/iso -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  ydfs3 
* docker logs --tail=10 -f ydfs3
* docker logs -f ydfs3 2>&1 |grep build

## Verbose Build, without sharing output ISO on host :

* docker run --name linuxconsole3 -e DIBAB_VERBOSE_BUILD=YES ydfs3

# Manual build

* docker run -d --name ydfs3 ydfs3 tail -f /dev/null 
* docker exec -ti ydfs3 bash
* cd $HOME
* git clone https://github.com/yledoare/ydfs.git
* cd ydfs
* cd testing
* make 

# Custom build

See inside "config.ini" (written when selected ARCH)
