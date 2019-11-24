# Build ydfs ISO

* mkdir iso
* chmod 777 iso

Automatic Build :

* docker run --name ydfs -d --mount type=bind,source="$(pwd)"/iso,target=/home/linuxconsole2019/iso  yledoare/ydfs 

Verbose Build, without sharing output ISO :

* docker run --name linuxconsole2019 -e DIBAB_VERBOSE_BUILD=YES yledoare/ydfs

Manual :

* docker run -d --name ydfs yledoare/ydfs tail -f /dev/null
* docker exec -ti ydfs bash
* git clone https://bitbucket.org/yourdistrofromscratch/ydfs.git
* cd ydfs
* cd 2.7
* make 
