SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
				  -e s/arm.*/arm/ -e s/sa110/arm/ \
				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
				  -e s/sh[234].*/sh/ )
ARCH		?= $(SUBARCH)
include config.ini

THEMODULENAME1=$(shell echo ${MODULES} | sed -e s/${ARCH}//g -e s/drivers-// -e s/firmware-// )
THEMODULENAME = $(subst -, ,$(THEMODULENAME1))
export OLDPATH=${PATH}
export DIBAB_ARCH=${ARCH}
export ARCH
export KERNEL3
export MEDIA
export SUBARCH
export BUILD_DESKTOP
export DISTRONAME
export TOOLCHAIN
export HOME_DIBAB
export DIBAB_VERBOSE_BUILD
export MKSQUASHFS_OPT
export MENUCONFIG
export BUILD_TOOLCHAIN
export SKIP_OPKG_ERROR
export CROSSTOOL
export GNU=gnu
export VENDOR=unknown
ifeq ($(ARCH),x86)
  export CPU=i686
else
  export CPU=${ARCH}
endif
ifeq ($(ARCH),arm)
KNAME=zImage
export LIST=${SUBARCH}
# export GNU=uclibcgnueabi
export GNU=gnueabi
export TOOLCHAIN_PREFIX=arm
export VENDOR=unknown
  ifeq ($(TOOLCHAIN),FriendlyARM)
    GCCPATH = ${HOME}/ydfs/toolchain/arm/opt/FriendlyARM/toolschain/4.4.3/bin/
    export PATH := ${PATH}:${GCCPATH}
    export CROSS_PREFIX=arm-linux
    export CROSS_COMPILE=arm-linux-
    export CC=${CROSS_COMPILE}gcc -march=armv4t -mtune=arm920t
  endif
  ifeq ($(TOOLCHAIN),buildroot)
    GCCPATH = ${HOME}/ydfs/buildroot-2011.08/output/host/usr/bin/
    export PATH := ${PATH}:${GCCPATH}
    export PATH
    export CROSS_PREFIX=arm-linux
    export CROSS_COMPILE=arm-linux-
    export CC=${CROSS_COMPILE}gcc -march=armv4t -mtune=arm920t
  endif
  ifeq ($(TOOLCHAIN),crosstool-ng)
    GCCPATH = ${HOME}/ydfs/x-tools/arm-${VENDOR}-linux-${GNU}/bin/
    export PATH := ${PATH}:${GCCPATH}
    export PATH
    export CROSS_PREFIX=arm-${VENDOR}-linux-${GNU}
    export CROSS_COMPILE=arm-${VENDOR}-linux-${GNU}-
    export CC=${CROSS_COMPILE}gcc -march=armv4t -mtune=arm920t
  endif
  ifeq ($(SUBARCH),$(filter $(SUBARCH),raspi raspi-qemu))
  ifeq ($(TOOLCHAIN),crosstool-ng)
     GCCPATH = ${HOME}/ydfs/x-tools/arm-${VENDOR}-linux-${GNU}/bin/
     export CROSS_COMPILE=${TOOLCHAIN_PREFIX}-${VENDOR}-linux-${GNU}-
     export CROSS_PREFIX=${TOOLCHAIN_PREFIX}-${VENDOR}-linux-${GNU}
  else
     # export VENDOR=bcm2708
     # GCCPATH = ${HOME}/ydfs/tools-master/arm-bcm2708/arm-bcm2708-linux-gnueabi/bin/
     #export VENDOR=tools6h
     #export GNUPATH=gnueabihf
     #GCCPATH=${HOME}/ydfs/x-tools6h/arm-unknown-linux-gnueabihf/bin
     #export CROSS_COMPILE=${ARCH}-unknown-linux-${GNU}-
     #export CROSS_PREFIX=${ARCH}-unknown-linux-${GNU}
     #export CC=${CROSS_COMPILE}gcc  -Ofast -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s
     export VENDOR=linaro-arm
     TOOLCHAIN_PREFIX=gcc
     export GNU=gnueabihf
     export GNUPATH=gnueabihf-raspbian
     GCCPATH=${HOME}/ydfs/tools-master/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/
     export CROSS_COMPILE=${ARCH}-linux-${GNU}-
     export CROSS_PREFIX=${ARCH}-linux-${GNU}
     export CC=${CROSS_COMPILE}gcc -Ofast -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s
  endif
    export PATH := ${PATH}:${GCCPATH}
    export PATH
    export CC=${CROSS_COMPILE}gcc
    export CXX=${CROSS_COMPILE}g++
  endif
else
KNAME=bzImage
export LIST=${ARCH}
  ifeq ($(TOOLCHAIN),crosstool-ng)
    export CROSS_PREFIX=${CPU}-ydfs-linux-gnu
    export CROSS_COMPILE=${CROSS_PREFIX}-
    GCCPATH = ${HOME}/ydfs/x-tools/${CROSS_PREFIX}/bin/
    export PATH := ${PATH}:${GCCPATH}
    export CC=${CROSS_COMPILE}gcc 
    export MENUCONFIG
  endif
endif
INITRAMFS=$(shell echo $(KERNEL3) | tr -d '.')
ISOPATH=$(shell echo $(ISOTMP)/$(DISTRONAME).$(LCBUILD)-$(ARCH)$(MEDIA).iso)
export ISOPATH
all: config.ini toolchain ${HOME}/${ARCH}/buildenv busybox initramfs linux core firmware drivers $(DISTRONAME) modules iso sleep

sleep:
	echo "Sleeping 60 minutes .. "
	sleep 6000
 
${HOME}/ydfs/x-tools/i386-unknown-linux-uclibc/bin/i386-unknown-linux-uclibc-gcc:
	./scripts/make_busybox_toolchain
busybox-toolchain: ${HOME}/ydfs/x-tools/i386-unknown-linux-uclibc/bin/i386-unknown-linux-uclibc-gcc

busybox: busybox-toolchain ${HOME}/ydfs/build/busybox-${ARCH}-${BUSYBOX}/_install

${HOME}/ydfs/build/busybox-${ARCH}-${BUSYBOX}/_install:
	./scripts/make_busybox ${BUSYBOX}

${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/.config:
	./scripts/make_linux

${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/arch/${ARCH}/boot/${KNAME}: scripts/make_linux # ${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/.config config/kernel-${ARCH}/config
	echo "build " ${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/arch/${ARCH}/boot/${KNAME}
	./scripts/make_linux

linux: ${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/arch/${ARCH}/boot/${KNAME} 

${HOME}/ydfs/build-${ARCH}/${INITRAMFS}: config.ini init-${ARCH}/ydfs/detect/media init-${ARCH}/ydfs/detect/hardware init-${ARCH}/ydfs/detect/modules init-${ARCH} init-${ARCH}/etc/init.d/rcS init-${ARCH}/etc/profile scripts/make_initramfs
	./scripts/make_initramfs

initramfs: ${HOME}/ydfs/build-${ARCH}/${INITRAMFS}

crosstool-ng-x86_64:
	echo Bug with recursion
	echo run ./scripts/make_crosstool-ng-x86_64
	#./scripts/make_crosstool-ng-x86_64
${GCCPATH}: 
	./scripts/make_toolchain
toolchain: ${GCCPATH}
iso: ${ISOPATH}
metalink:
	./scripts/iso_to_metalink

${ISOPATH}: ${HOME}/ydfs/build-${ARCH}/${INITRAMFS} ${LCMBUILD}/${ARCH}.squashfs config.ini #  ${LCMBUILD}
	./scripts/make_iso
synciso: initramfs iso
	scp /home/linuxconsole25/ydfs/iso/linuxconsole.iso yann@192.168.1.47:.

config.ini:
	./scripts/make_config_ini
live-test:
	./scripts/make_live_test
test-arm:
	./scripts/make_test_arm
logs:
	./scripts/upload_logs
desktop-menus:
	./scripts/install-desktop-menus
wineprogs:
	./scripts/get_wine_progs
test:
	./scripts/make_test
test2:
	@echo ${ISOPATH}
#	@echo ${KERNEL3} | tr -d '.'
cleanmultilib:
	./scripts/make_clean_multilib
distclean:
	./scripts/make_distclean
clean-opkg:
	./scripts/make_clean_opkg
clean:
	./scripts/make_clean
ifeq ($(ARCH),x86)
	rm ${ISOPATH}
	rm ${LCMBUILD}/*
endif
ifeq ($(ARCH),arm)
	rm -fR ${HOME}/${ARCH}/*
endif
	
${HOME}/${ARCH}/buildenv: packages/list-${LIST}
	./scripts/make_packages ${LIST}
core: ${LCMBUILD}/${ARCH}.squashfs 
drivers: ${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/.config ${LCMBUILD}/drivers-${ARCH}.squashfs
firmware: ${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/.config ${LCMBUILD}/firmware-${ARCH}.squashfs

${LCMBUILD}/firmware-${ARCH}.squashfs: ${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/.config
	./scripts/make_firmwares
${LCMBUILD}/drivers-${ARCH}.squashfs: ${HOME}/ydfs/build/linux-${ARCH}-${KERNEL3}/.config
	./scripts/make_drivers
${LCMBUILD}/${ARCH}.squashfs: packages/list-${LIST} scripts/make_modules
	./scripts/make_modules

check:
	./scripts/check_url
archives: ${HOME}/ydfs/archives/${ARCH}-${VENDOR}-linux-toolchain.tar.bz2

${HOME}/ydfs/archives/${ARCH}-${VENDOR}-linux-toolchain.tar.bz2:
	./scripts/make_archives
elementary: packages/list-elementary
	./scripts/make_packages elementary
pantheon: packages/list-pantheon
	./scripts/make_packages pantheon
hackerOS: packages/list-hackerOS
	./scripts/make_packages hackerOS
	./scripts/make_module hackerOS


# modules: firefox games music office video multimedia fps network emulators graphics
modules: firefox games music office video multimedia fps network emulators graphics chromium

virtualbox: ${LCMBUILD}/virtualbox-${ARCH}.squashfs
${LCMBUILD}/virtualbox-${ARCH}.squashfs : packages/list-virtualbox
	./scripts/make_packages virtualbox
	./scripts/make_module virtualbox

games: ${LCMBUILD}/games-${ARCH}.squashfs
${LCMBUILD}/games-${ARCH}.squashfs : packages/list-games
	./scripts/make_packages games
	./scripts/make_module games

video: ${LCMBUILD}/video-${ARCH}.squashfs
${LCMBUILD}/video-${ARCH}.squashfs : packages/list-video
	./scripts/make_packages video
	./scripts/make_module video

music: ${LCMBUILD}/music-${ARCH}.squashfs
${LCMBUILD}/music-${ARCH}.squashfs : packages/list-music
	./scripts/make_packages music
	./scripts/make_module music

devtools: ${LCMBUILD}/devtools-${ARCH}.squashfs
${LCMBUILD}/devtools-${ARCH}.squashfs : packages/list-devtools
	./scripts/make_packages devtools
	./scripts/make_module devtools

accessibility: ${LCMBUILD}/accessibility-${ARCH}.squashfs
${LCMBUILD}/accessibility-${ARCH}.squashfs : packages/list-accessibility
	./scripts/make_packages accessibility
	./scripts/make_module accessibility

emulators: ${LCMBUILD}/emulators-${ARCH}.squashfs
${LCMBUILD}/emulators-${ARCH}.squashfs : packages/list-emulators
	./scripts/make_packages emulators
	./scripts/make_module emulators

multimedia: ${LCMBUILD}/multimedia-${ARCH}.squashfs
${LCMBUILD}/multimedia-${ARCH}.squashfs : packages/list-multimedia
	./scripts/make_packages multimedia
	./scripts/make_module multimedia

network: ${LCMBUILD}/network-${ARCH}.squashfs
${LCMBUILD}/network-${ARCH}.squashfs : packages/list-network
	./scripts/make_packages network
	./scripts/make_module network

graphics: ${LCMBUILD}/graphics-${ARCH}.squashfs
${LCMBUILD}/graphics-${ARCH}.squashfs : packages/list-graphics
	./scripts/make_packages graphics
	./scripts/make_module graphics

fps: ${LCMBUILD}/fps-${ARCH}.squashfs
${LCMBUILD}/fps-${ARCH}.squashfs : packages/list-fps
	./scripts/make_packages fps
	./scripts/make_module fps

chromium: ${LCMBUILD}/chromium-${ARCH}.squashfs
${LCMBUILD}/chromium-${ARCH}.squashfs : packages/list-chromium
	./scripts/make_packages chromium
	./scripts/make_module chromium

firefox: ${LCMBUILD}/firefox-${ARCH}.squashfs
${LCMBUILD}/firefox-${ARCH}.squashfs : packages/list-firefox
	./scripts/make_packages firefox
	./scripts/make_module firefox

office: ${LCMBUILD}/office-${ARCH}.squashfs
${LCMBUILD}/office-${ARCH}.squashfs : packages/list-office
	./scripts/make_packages office
	./scripts/make_module office

clean-linuxconsole:
	# rm ${HOME}/ydfs/build/modules/linuxconsole-${ARCH}.squashfs
	rm -fR ${HOME}/linuxconsole/
	FORCEBUILD=OK make linuxconsole
linuxconsole: ${LCMBUILD}linuxconsole-${ARCH}.squashfs
${LCMBUILD}linuxconsole-${ARCH}.squashfs : packages/list-linuxconsole
	./scripts/make_packages linuxconsole
	./scripts/make_module linuxconsole
   
multilib: 
	./scripts/make_multilib
dist: 
	./scripts/make_opkg_filelist opkg
fixopkg:
	./scripts/make_thunderbird
	./scripts/make_fixes
#	./scripts/make_firefox
#	./scripts/make_custom_opkg playonlinux
	./scripts/make_custom_opkg flash
#	./scripts/make_custom_opkg arabic
#	./scripts/make_custom_opkg spring
#	./scripts/make_chrome
	./scripts/make_opkg_filelist opkg
opkg: ${HOME}/ydfs/opkg/Packages
${HOME}/ydfs/opkg/Packages : packages/list-opkg-${DISTRONAME}
	cp packages/list-opkg-${DISTRONAME} packages/list-opkg
	./scripts/make_packages opkg
	./scripts/make_opkg_filelist opkg
   
linuxfr.org: ${LCMBUILD}linuxfr.org-${ARCH}.squashfs
${LCMBUILD}linuxfr.org-${ARCH}.squashfs : packages/list-linuxfr.org
	./scripts/make_packages linuxfr.org
	./scripts/make_module linuxfr.org
   
papyrus: ${LCMBUILD}papyrus-${ARCH}.squashfs

lanpower: ${LCMBUILD}lanpower-${ARCH}.squashfs
${LCMBUILD}lanpower-${ARCH}.squashfs : packages/list-lanpower
	./scripts/make_packages lanpower
	./scripts/make_module lanpower

clean-lanpower:
  #pour mettre à zéro la compil lanpower
	# rm ${HOME}/ydfs/build/modules/lanpower-${ARCH}.squashfs
	rm -fR ${HOME}/lanpower/
	FORCEBUILD=OK make lanpower
   
papyrus: ${LCMBUILD}papyrus-${ARCH}.squashfs
${LCMBUILD}papyrus-${ARCH}.squashfs : packages/list-papyrus
	./scripts/make_packages papyrus
	./scripts/make_module papyrus
   
kvm: ${LCMBUILD}kvm-${ARCH}.squashfs
${LCMBUILD}kvm-${ARCH}.squashfs : packages/list-kvm
	./scripts/make_packages kvm
	./scripts/make_module kvm
   
antivirus: ${LCMBUILD}antivirus-${ARCH}.squashfs
${LCMBUILD}antivirus-${ARCH}.squashfs : packages/list-antivirus
	./scripts/make_packages antivirus
	./scripts/make_module antivirus

archive:
	cd ..
	tar czvf linuxconsole-2.4.tar.gz --exclude config.ini --exclude .git 2.4
