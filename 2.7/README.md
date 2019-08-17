# Build ydfs ISO

* mkdir ydfs
* chmod 777 ydfs

Automatic Build :

* docker pull yledoare/ydfs
* docker run --mount type=bind,source="$(pwd)"/ydfs,target=/home/linuxconsole2019/ydfs  yledoare/ydfs

Verbose Build, without sharing output ISO :

* docker run --name linuxconsole2019 -e DIBAB_VERBOSE_BUILD=YES yledoare/ydfs

Manual :

* docker run yledoare/ydfs bash
* git clone https://bitbucket.org/yourdistrofromscratch/ydfs.git
* cd ydfs
* cd 2.7
* make 
