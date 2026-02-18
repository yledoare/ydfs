# If the first argument is "run"...
ifeq (docker,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  RUN_ARGS2 := -e $(wordlist 3,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

export YDFS = $(shell git rev-parse --abbrev-ref HEAD)
export YDFS_GIT_ID = $(shell git log -n1 --format="%h")

UNAME  = $(shell uname)

DOCKER_BUILDX  = $(shell docker --help |grep buildx)
ifeq ($(DOCKER_BUILDX),)
  DOCKER_BUILDX = $(shell which buildx-v0.21.1.linux-amd64)
  ifeq ($(DOCKER_BUILDX),)
    DOCKER_BUILD_CLI = docker
  else
    #Used to build YDFS2.11 from LinuxConsole 2024
    DOCKER_BUILD_CLI = buildx-v0.21.1.linux-amd64
  endif
else
  DOCKER_BUILD_CLI = docker
  DOCKER_BUILD_CLI_OPTION = buildx
endif

DOCKER_CLI = docker
HOME_DOCKER = /ydfs${YDFS}/linuxconsole2025

ifeq ($(UNAME),Darwin)
ARCH=x86_64
else
ARCH=$(shell uname -m | sed -e s/i.86/x86/ -e s/sun4u/sparc64/ \
				  -e s/arm.*/arm/ -e s/sa110/arm/ \
				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
				  -e s/sh[234].*/sh/ )
endif


ISTTY = $(shell tty -s || echo NOTTY)
#DOCKERIMAGE64 = $(shell ${DOCKER_CLI} image ls | grep ydfs64-${YDFS} | cut -d' ' -f1)
DOCKERIMAGE64="yledoare/ydfs-2.11"
ifeq ($(ISTTY),NOTTY)
	OPTION=
else
	OPTION=-ti
endif

DOCKER=${DOCKER_CLI} run ${OPTION} --rm --security-opt seccomp=unconfined \
	-v ${HOME}/ydfs-build/ydfs:${HOME_DOCKER}/ydfs \
	-v ${HOME}/ydfs-build/${ARCH}:${HOME_DOCKER}/${ARCH} \
	-v ${HOME}/ydfs-build/archpkg:${HOME_DOCKER}/archpkg \
	-v ${HOME}/ydfs-build/multilib:${HOME_DOCKER}/multilib \
	-v ${HOME}/ydfs-build/linuxconsole:${HOME_DOCKER}/linuxconsole \
	-v ${HOME}/ydfs-build/iso:${HOME_DOCKER}/iso \
	-v ${PWD}:/ydfs-src \
	-w=/ydfs-src \
	--platform=linux/amd64 \
	-e HOME_DIBAB=/ydfs-src/core \
	-e SEND_BUILD_LOG=YES #\
#	--user $(shell id -u):$(shell id -g)

all: linuxconsole

linuxconsole: iso

#iso: docker-image-64 prepare core/packages/list-x86_64
iso: prepare core/packages/list-x86_64
	${DOCKER} ydfs64-${YDFS} /bin/sh -c 'cd core; make iso'

clean:
	rm -fR ${HOME}/ydfs-build

prepare:
	@echo "DOCKER_BUILD_CLI is $(DOCKER_BUILD_CLI) ${DOCKER_BUILD_CLI_OPTION}"
	@echo "Arch is ${ARCH}"
	@echo -n prepare ..
	@install -d ${HOME}/ydfs-build/ydfs
	@install -d ${HOME}/ydfs-build/multilib
	@install -d ${HOME}/ydfs-build/linuxconsole
	@install -d ${HOME}/ydfs-build/archpkg
	@install -d ${HOME}/ydfs-build/iso
	@install -d ${HOME}/ydfs-build/${ARCH}
	@echo $(YDFS) > ydfs
	@echo $(YDFS_GIT_ID) > ydfs-git-id
	@chmod 777 ${HOME}/ydfs-build/ydfs
	@chmod 777 ${HOME}/ydfs-build/multilib
	@chmod 777 ${HOME}/ydfs-build/archpkg
	@test -f ${HOME}/ydfs-dbuild/archpkg/tcl || cp archpkg/* ${HOME}/ydfs-build/archpkg
	@chmod 777 ${HOME}/ydfs-build/iso
	@chmod 777 ${HOME}/ydfs-build/${ARCH}
	@echo done 

force-docker-image-64: core/Dockerfile
	cp core/Dockerfile core/Dockerfile-with-user
	$(shell(echo RUN useradd $(shell whoami) --create-home >> core/Dockerfile-with-user)
	echo USER $(shell whoami) >> core/Dockerfile-with-user
	cd core && ${DOCKER_BUILD_CLI} ${DOCKER_BUILD_CLI_OPTION} build --platform=linux/amd64 -f Dockerfile-with-user -t ydfs64-${YDFS} .

docker-image-64: core/Dockerfile
ifneq ($(DOCKERIMAGE64),ydfs64-${YDFS})
	cp core/Dockerfile core/Dockerfile-with-user
	echo "RUN install -d /ydfs${YDFS}" >> core/Dockerfile-with-user 
	echo "RUN useradd linuxconsole2025 --home-dir  ${HOME_DOCKER}  --create-home " >> core/Dockerfile-with-user
	echo "USER linuxconsole2025" >> core/Dockerfile-with-user
	cd core && ${DOCKER_BUILD_CLI} ${DOCKER_BUILD_CLI_OPTION} build --platform=linux/amd64 -f Dockerfile-with-user -t ydfs64-${YDFS} .
endif

force-iso:
	@touch core/packages/list-x86_64

verbose:
	${DOCKER} -e DIBAB_VERBOSE_BUILD=YES ydfs64-${YDFS} /bin/sh -c 'cd core; make iso'

cleanmultilib:
	${DOCKER} ydfs64-${YDFS} /bin/sh -c 'cd core; make cleanmultilib'
multilib:
	${DOCKER} ydfs64-${YDFS} /bin/sh -c 'cd core; make multilib'

buildme:
	${DOCKER} -e BUILDME=OK ydfs64-${YDFS} /bin/sh -c 'cd core; make iso'
test2:
	cd core && make test2
test:
	cd core && make test
xbmc:
	${DOCKER} -e DIBAB_VERBOSE_BUILD=YES ydfs64-${YDFS} /bin/sh -c 'cd core; make xbmc'

live-test:
	${DOCKER} -e BUILDME=OK ydfs64-${YDFS} /bin/sh -c 'cd core; make live-test'

dist-opkg: 
	${DOCKER} ydfs64-${YDFS} /bin/sh -c 'cd core; make dist'

dist-fast-kernel: fast-kernel
	scp ${HOME}/iso/kernel-modules-${YDFS}-${ARCH}.tar.gz jukebox.linuxconsole.org@jukebox.linuxconsole.org:/home/jukebox.linuxconsole.org/www/fast/kernel-modules-${YDFS}-${ARCH}.tar.gz
	scp ${HOME}/iso/kernel-${YDFS}-${ARCH}.tar.gz jukebox.linuxconsole.org@jukebox.linuxconsole.org:/home/jukebox.linuxconsole.org/www/fast/kernel-${YDFS}-${ARCH}.tar.gz

updates:
	${DOCKER} ydfs64-${YDFS} /bin/sh -c 'cd core; make updates'

uninstall:
	${DOCKER} ydfs64-${YDFS} /bin/sh -c 'cd core; scripts/uninstall-package giflib-5.2.2'

bash: prepare
	${DOCKER} ydfs64-${YDFS} bash

root: prepare
	${DOCKER} -u root ydfs64-${YDFS} bash


fast-kernel64: prepare
	${DOCKER} -e BUILDYDFS=fast_kernel ydfs64-${YDFS} /bin/sh -c 'cd core; make linux'

fast-64: prepare
	${DOCKER} -e BUILDYDFS=fast ydfs64-${YDFS} /bin/sh -c 'cd core; make iso'


core/packages/list-x86_64: core/packages/list-misclibs-x86_64 core/packages/list-guilibs-x86_64 core/packages/list-xorg2-x86_64 core/packages/list-core-x86_64 core/packages/list-perl-x86_64 core/packages/list-xorg-x86_64 core/packages/list-mate-x86_64 core/packages/list-wine-x86_64 core/packages/list-libreoffice-x86_64 core/packages/list-kde-x86_64 core/packages/list-misc-x86_64
	echo "#DO NOT WRITE HERE, GERNERATED FROM MAKEFILE" > core/packages/list-x86_64
	cat core/packages/list-core-x86_64 >> core/packages/list-x86_64
	cat core/packages/list-perl-x86_64 >> core/packages/list-x86_64
	cat core/packages/list-xorg-x86_64 >> core/packages/list-x86_64
	cat core/packages/list-xorg2-x86_64 >> core/packages/list-x86_64
	cat core/packages/list-guilibs-x86_64 >> core/packages/list-x86_64
#	cat core/packages/list-wine-x86_64 >> core/packages/list-x86_64
#	cat core/packages/list-misclibs-x86_64 >> core/packages/list-x86_64
#	cat core/packages/list-mate-x86_64 >> core/packages/list-x86_64
#	cat core/packages/list-libreoffice-x86_64 >> core/packages/list-x86_64
#	cat core/packages/list-kde-x86_64 >> core/packages/list-x86_64
#	cat core/packages/list-misc-x86_64 >> core/packages/list-x86_64
	cat core/packages/list-end-x86_64 >> core/packages/list-x86_64
#%::
#	@echo "Run docker $(RUN_ARGS)"
#	${DOCKER} ydfs64-${YDFS} /bin/sh -c 'cd core; make $(RUN_ARGS)'
initramfs:
	@echo "Run docker iso "
	${DOCKER} ydfs64-${YDFS} /bin/sh -c 'cd core; make initramfs'

verbose-iso:
	@echo "Run docker iso "
	${DOCKER} -e DIBAB_VERBOSE_BUILD=YES ydfs64-${YDFS} /bin/sh -c 'cd core; make iso'
touch:
	${DOCKER} -e DIBAB_VERBOSE_BUILD=YES ydfs64-${YDFS} /bin/sh -c 'cd core; make touch'
