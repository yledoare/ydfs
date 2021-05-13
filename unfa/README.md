# About Ydfs

(Your Distro From Scratch) is a tool to build your own linux distribution 

## Automatic Unfa 64 bits ISO Build

* docker run --name ydfs -d --mount type=bind,source="$(pwd)"/iso,target=/home/linuxconsole2021/iso -e DISTRO=unfa yledoare/ydfs28 
* docker logs --tail=10 -f ydfs
* ls iso
