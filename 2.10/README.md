
# Build and test

# Manual Docker build : Read doc/docker.txt

# Auto build

* docker-compose up -d

# Live Gui test 

* xhost +
* docker run --name ydfs-test -d --mount type=bind,source="$HOME"/iso,target=/home/linuxconsole2024/iso -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  ydfs64-2.10 
* docker exec -ti ydfs-test c 'cd $HOME/src/ydfs/2.10 ; make live-test'


# Write ISO to USB key

* dd if=iso/linuxconsole.iso of=/dev/sdf bs=4M status=progress oflag=sync

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
