# Build ydfs ISO

* mkdir ydfs
* chmod 77 ydfs

Automatic Build :

* docker pull yledoare/ydfs
* docker run --mount type=bind,source="$(pwd)"/ydfs,target=/home/linuxconsole2019/ydfs  yledoare/ydfs

Manual :

* docker run yledoare/ydfs bash
* git clone https://bitbucket.org/yourdistrofromscratch/ydfs.git
* cd ydfs
* cd 2.7
* make 
