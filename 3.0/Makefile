SUBCARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
				  -e s/arm.*/arm/ -e s/sa110/arm/ \
				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
				  -e s/sh[234].*/sh/ )
CARCH		?= $(SUBCARCH)
include config.ini

THEMODULENAME1=$(shell echo ${MODULES} | sed -e s/${CARCH}//g -e s/drivers-// -e s/firmware-// )
THEMODULENAME = $(subst -, ,$(THEMODULENAME1))
export OLDPATH=${PATH}
export DIBAB_CARCH=${CARCH}
export CARCH
export KERNEL3
export MEDIA
export SUBCARCH
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
export CPU=${CARCH}
ifeq ($(CARCH),arm)
KNAME=zImage
export GNU=gnueabi
export TOOLCHAIN_PREFIX=arm
export VENDOR=unknown
  ifeq ($(TOOLCHAIN),FriendlyARM)
    GCCPATH = ${HOME}//toolchain/arm/opt/FriendlyARM/toolschain/4.4.3/bin/
    export PATH := ${PATH}:${GCCPATH}
    export CROSS_PREFIX=arm-linux
    export CROSS_COMPILE=arm-linux-
    export CC=${CROSS_COMPILE}gcc -march=armv4t -mtune=arm920t
  endif
  ifeq ($(TOOLCHAIN),buildroot)
    GCCPATH = ${HOME}//buildroot-2011.08/output/host/usr/bin/
    export PATH := ${PATH}:${GCCPATH}
    export PATH
    export CROSS_PREFIX=arm-linux
    export CROSS_COMPILE=arm-linux-
    export CC=${CROSS_COMPILE}gcc -march=armv4t -mtune=arm920t
  endif
  ifeq ($(TOOLCHAIN),crosstool-ng)
    GCCPATH = ${HOME}//x-tools/arm-${VENDOR}-linux-${GNU}/bin/
    export PATH := ${PATH}:${GCCPATH}
    export PATH
    export CROSS_PREFIX=arm-${VENDOR}-linux-${GNU}
    export CROSS_COMPILE=arm-${VENDOR}-linux-${GNU}-
    export CC=${CROSS_COMPILE}gcc -march=armv4t -mtune=arm920t
  endif
  ifeq ($(SUBCARCH),$(filter $(SUBCARCH),raspi raspi-qemu))
  ifeq ($(TOOLCHAIN),crosstool-ng)
     GCCPATH = ${HOME}//x-tools/arm-${VENDOR}-linux-${GNU}/bin/
     export CROSS_COMPILE=${TOOLCHAIN_PREFIX}-${VENDOR}-linux-${GNU}-
     export CROSS_PREFIX=${TOOLCHAIN_PREFIX}-${VENDOR}-linux-${GNU}
  else
     export VENDOR=linaro-arm
     TOOLCHAIN_PREFIX=gcc
     export GNU=gnueabihf
     export GNUPATH=gnueabihf-raspbian
     GCCPATH=${HOME}//tools-master/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/
     export CROSS_COMPILE=${CARCH}-linux-${GNU}-
     export CROSS_PREFIX=${CARCH}-linux-${GNU}
     export CC=${CROSS_COMPILE}gcc -Ofast -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s
  endif
    export PATH := ${PATH}:${GCCPATH}
    export PATH
    export CC=${CROSS_COMPILE}gcc
    export CXX=${CROSS_COMPILE}g++
  endif
else
KNAME=bzImage
  ifeq ($(TOOLCHAIN),crosstool-ng)
    export CROSS_PREFIX=${CPU}--linux-gnu
    export CROSS_COMPILE=${CROSS_PREFIX}-
    GCCPATH = ${HOME}//x-tools/${CROSS_PREFIX}/bin/
    export PATH := ${PATH}:${GCCPATH}
    export CC=${CROSS_COMPILE}gcc 
    export MENUCONFIG
  endif
endif
INITRAMFS=$(shell echo $(KERNEL3) | tr -d '.')
ISOPATH=$(shell echo $(ISOTMP)/$(DISTRONAME).$(LCBUILD)-$(CARCH)$(MEDIA).iso)
export ISOPATH
all: config.ini toolchain ${HOME}/${CARCH}/buildenv busybox initramfs linux modules firmware drivers iso # opkg fixopkg iso
${HOME}//x-tools/i386-unknown-linux-uclibc/bin/i386-unknown-linux-uclibc-gcc:
	./scripts/make_busybox_toolchain
busybox-toolchain: ${HOME}//x-tools/i386-unknown-linux-uclibc/bin/i386-unknown-linux-uclibc-gcc

busybox: busybox-toolchain ${HOME}//build/busybox-${CARCH}-${BUSYBOX}/_install

${HOME}//build/busybox-${CARCH}-${BUSYBOX}/.config:
	./scripts/make_busybox ${BUSYBOX}

${HOME}//build/busybox-${CARCH}-${BUSYBOX}/_install: ${HOME}//build/busybox-${CARCH}-${BUSYBOX}/.config
	./scripts/make_busybox ${BUSYBOX}

${HOME}//build/linux-${CARCH}-${KERNEL3}/.config:
	./scripts/make_linux

${HOME}//build/linux-${CARCH}-${KERNEL3}/arch/${CARCH}/boot/${KNAME}: scripts/make_linux 
	echo "build " ${HOME}//build/linux-${CARCH}-${KERNEL3}/arch/${CARCH}/boot/${KNAME}
	./scripts/make_linux

linux: ${HOME}//build/linux-${CARCH}-${KERNEL3}/arch/${CARCH}/boot/${KNAME} 

${HOME}//build_${CARCH}/${INITRAMFS}: config.ini init-${CARCH}//detect/media init-${CARCH}//detect/modules init-${CARCH} init-${CARCH}/etc/init.d/rcS init-${CARCH}/etc/profile scripts/make_initramfs
	./scripts/make_initramfs

initramfs: ${HOME}//build_${CARCH}/${INITRAMFS}

${GCCPATH}: 
	./scripts/make_toolchain
toolchain: ${GCCPATH}
iso: ${ISOPATH}
metalink:
	./scripts/iso_to_metalink

${ISOPATH}: ${HOME}//build_${CARCH}/${INITRAMFS} ${LCMBUILD} config.ini 
	./scripts/make_iso

config.ini:
	./scripts/make_config_ini
live-test:
	./scripts/make_live_test
test-arm:
	./scripts/make_test_arm
logs:
	./scripts/upload_logs
test:
	./scripts/make_test
test2:
	@echo ${ISOPATH}
distclean:
	./scripts/make_distclean
clean:
	rm -fR ${HOME}/${CARCH}
	rm -fR ${HOME}//build_${CARCH}/*
	rm -fR ${HOME}//src/bzip2-1.0.6/
	rm -fR ${HOME}//src/libmad-0.15.*
	rm -fR ${HOME}//src/libomxil-bellagio-*
	rm -fR ${HOME}//src/perl*/
	rm -fR ${HOME}//src/SDL_Pango-0.1.2/
	rm -fR ${HOME}//src/vim*/
	rm -fR ${HOME}/.cpan
	rm -fR ${HOME}//modules/*
	rm -fR ${HOME}//build/modules/*
	rm -fR ${HOME}//packages/
	rm -fR ${HOME}//src/notify-python*
	rm -fR ${HOME}//packages-${CARCH}/*
ifeq ($(CARCH),x86)
	rm ${ISOPATH}
	rm ${LCMBUILD}/*
endif
ifeq ($(CARCH),arm)
	rm -fR ${HOME}/${CARCH}/*
endif
	
${HOME}/${CARCH}/buildenv: core/${CARCH}.list
	cd core && ../scripts/build_core ${CARCH}
modules: ${LCMBUILD}/${CARCH}.squashfs 
drivers: ${HOME}//build/linux-${CARCH}-${KERNEL3}/.config ${LCMBUILD}/drivers-${CARCH}.squashfs
firmware: ${HOME}//build/linux-${CARCH}-${KERNEL3}/.config ${LCMBUILD}/firmware-${CARCH}.squashfs

${LCMBUILD}/firmware-${CARCH}.squashfs: ${HOME}//build/linux-${CARCH}-${KERNEL3}/.config
	./scripts/make_firmwares
${LCMBUILD}/drivers-${CARCH}.squashfs: ${HOME}//build/linux-${CARCH}-${KERNEL3}/.config
	./scripts/make_drivers
${LCMBUILD}/${CARCH}.squashfs: core/${CARCH}.list scripts/make_modules
	./scripts/make_modules

check:
	./scripts/check_url
archives: ${HOME}//archives/${CARCH}-${VENDOR}-linux-toolchain.tar.bz2

${HOME}//archives/${CARCH}-${VENDOR}-linux-toolchain.tar.bz2:
	./scripts/make_archives
video: packages/list-video
	./scripts/make_packages video
qt: packages/list-qt
	./scripts/make_packages qt
elementary: packages/list-elementary
	./scripts/make_packages elementary
music: packages/list-music
	./scripts/make_packages music
audio: packages/list-audio
	./scripts/make_packages audio
server: packages/list-server
	./scripts/make_packages server
pantheon: packages/list-pantheon
	./scripts/make_packages pantheon

new: ${LCMBUILD}new-${CARCH}.squashfs
${LCMBUILD}new-${CARCH}.squashfs : packages/list-new
	./scripts/make_packages new

clean-linuxconsole:
	rm -fR ${HOME}/linuxconsole/
	FORCEBUILD=OK make linuxconsole
linuxconsole: ${LCMBUILD}linuxconsole-${CARCH}.squashfs
${LCMBUILD}linuxconsole-${CARCH}.squashfs : packages/list-linuxconsole
	./scripts/make_packages linuxconsole
	./scripts/make_module linuxconsole
   
dist: 
	./scripts/make_opkg_filelist opkg
fixopkg:
	./scripts/make_fixes
	./scripts/make_opkg_filelist opkg
opkg: ${HOME}//opkg/Packages
${HOME}//opkg/Packages : packages/list-opkg-${DISTRONAME}
	cp packages/list-opkg-${DISTRONAME} packages/list-opkg
	./scripts/make_packages opkg
	./scripts/make_opkg_filelist opkg
   
linuxfr.org: ${LCMBUILD}linuxfr.org-${CARCH}.squashfs
${LCMBUILD}linuxfr.org-${CARCH}.squashfs : packages/list-linuxfr.org
	./scripts/make_packages linuxfr.org
	./scripts/make_module linuxfr.org
   
papyrus: ${LCMBUILD}papyrus-${CARCH}.squashfs

lanpower: ${LCMBUILD}lanpower-${CARCH}.squashfs
${LCMBUILD}lanpower-${CARCH}.squashfs : packages/list-lanpower
	./scripts/make_packages lanpower
	./scripts/make_module lanpower

clean-lanpower:
  #pour mettre à zéro la compil lanpower
	rm -fR ${HOME}/lanpower/
	FORCEBUILD=OK make lanpower
   
papyrus: ${LCMBUILD}papyrus-${CARCH}.squashfs
${LCMBUILD}papyrus-${CARCH}.squashfs : packages/list-papyrus
	./scripts/make_packages papyrus
	./scripts/make_module papyrus
   
kvm: ${LCMBUILD}kvm-${CARCH}.squashfs
${LCMBUILD}kvm-${CARCH}.squashfs : packages/list-kvm
	./scripts/make_packages kvm
	./scripts/make_module kvm
   
antivirus: ${LCMBUILD}antivirus-${CARCH}.squashfs
${LCMBUILD}antivirus-${CARCH}.squashfs : packages/list-antivirus
	./scripts/make_packages antivirus
	./scripts/make_module antivirus

archive:
	cd ..
	tar czvf linuxconsole-2.4.tar.gz --exclude config.ini --exclude .git 2.4
