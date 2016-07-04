pkgdir=$HOME/ydfs/packages-$ARCH/catalyst13
pkgname=catalyst13
pkgver=13.1
pkgrel=26
pkgdesc="AMD/ATI Catalyst drivers for linux. fglrx kernel module only. Radeons HD 2 3 4 xxx ARE NOT SUPPORTED"
_kernver=3.14.8

srcdir=$PWD
[ -e ati-catalyst-13/buildok-x86_64 ] && exit 0
if [ ! -e ati-catalyst-13 ]
then
   #chmod +x amd-driver-installer-catalyst-${pkgver}-legacy-linux-x86.x86_64.run
   /bin/sh ./amd-driver-installer-catalyst-${pkgver}-legacy-linux-x86.x86_64.run --extract ati-catalyst-13
fi
	BUILDARCH=x86_64
	_archdir=x86_64
      if [ "${ARCH}" = "x86" ]; then
	BUILDARCH=i386
	_archdir=x86
      fi
      cd ${srcdir}/ati-catalyst-13 || exit $?
[ ! -e catalyst-total-hd234k.tar.gz ] && wget https://aur.archlinux.org/packages/ca/catalyst-total-hd234k/catalyst-total-hd234k.tar.gz && tar xzvf catalyst-total-hd234k.tar.gz && mv catalyst-total-hd234k/* .
     
      patch -Np1 -i makefile_compat.patch
      patch -Np1 -i 3.5-do_mmap.patch
      patch -Np1 -i arch-fglrx-3.7.patch
      patch -Np1 -i arch-fglrx-3.8.patch
      patch -Np0 -i gentoo_linux-3.10-proc.diff
      patch -l -Np1 -i foutrelis_3.10_fix_for_legacy.patch
      patch -Np1 -i lano1106_fglrx_intel_iommu.patch
      patch -Np1 -i lano1106_kcl_agp_13_4.patch
      patch -Np1 -i arch_3.13_kernel_acpi_node.patch
      patch -Np1 -i cold-fglrx-3.14-current_euid.patch
 
      cd ${srcdir}/ati-catalyst-13/common/lib/modules/fglrx/build_mod
      cp ${srcdir}/ati-catalyst-13/arch/${_archdir}/lib/modules/fglrx/build_mod/libfglrx_ip.a .
      cp 2.6.x/Makefile .
      CFLAGS_MODULE="-DMODULE -DATI -DFGL -DPAGE_ATTR_FIX=$PAGE_ATTR_FIX -DCOMPAT_ALLOC_USER_SPACE=$COMPAT_ALLOC_USER_SPACE $def_smp $def_modversions"
#	make -C /home/ydfs-amd64/ydfs/build/linux-x86_64-3.14.8 SUBDIRS="`pwd`" modules
#     exit 0
 make -C $HOME/ydfs/build/linux-x86_64-${_kernver}/ $HOME/ydfs/build/linux-x86_64-${_kernver} SUBDIRS="`pwd`" ARCH=${BUILDARCH} \
      MODFLAGS="$CFLAGS_MODULE" \
      CFLAGS_MODULE="$CFLAGS_MODULE" \
      PAGE_ATTR_FIX=$PAGE_ATTR_FIX COMPAT_ALLOC_USER_SPACE=$COMPAT_ALLOC_USER_SPACE modules V=1

  install -d $pkgdir/etc/modules
  cp ./fglrx.ko $pkgdir/etc/modules || exit 1

      cd ${srcdir}/ati-catalyst-13
	install -D -m755 lib-catalyst.sh ${pkgdir}/etc/profile.d/lib-catalyst.sh

   ## Install userspace tools and libraries
    # Create directories
      install -m755 -d ${pkgdir}/etc/ati
      install -m755 -d ${pkgdir}/etc/rc.d
      install -m755 -d ${pkgdir}/etc/profile.d
      install -m755 -d ${pkgdir}/etc/acpi/events
      install -m755 -d ${pkgdir}/etc/security/console.apps
      install -m755 -d ${pkgdir}/etc/OpenCL/vendors

      install -m755 -d ${pkgdir}/usr/lib/xorg/modules/dri
      install -m755 -d ${pkgdir}/usr/lib/xorg/modules/drivers
      install -m755 -d ${pkgdir}/usr/lib/xorg/modules/extensions
      install -m755 -d ${pkgdir}/usr/lib/xorg/modules/extensions/fglrx
      install -m755 -d ${pkgdir}/usr/lib/xorg/modules/linux
      install -m755 -d ${pkgdir}/usr/lib/dri
      install -m755 -d ${pkgdir}/usr/lib/fglrx
      install -m755 -d ${pkgdir}/usr/lib/systemd/system

      install -m755 -d ${pkgdir}/usr/bin

      install -m755 -d ${pkgdir}/usr/include/GL

      install -m755 -d ${pkgdir}/usr/share/applications
      install -m755 -d ${pkgdir}/usr/share/ati/amdcccle
      install -m755 -d ${pkgdir}/usr/share/licenses/${pkgname}
      install -m755 -d ${pkgdir}/usr/share/man/man8
      install -m755 -d ${pkgdir}/usr/share/pixmaps

    # X.org driver
      if [ "${ARCH}" = "x86" ]; then
	cd ${srcdir}/ati-catalyst-13/xpic/usr/X11R6/lib/modules
      elif [ "${ARCH}" = "x86_64" ]; then
	cd ${srcdir}/ati-catalyst-13/xpic_64a/usr/X11R6/lib64/modules
      fi

      install -m755 *.so ${pkgdir}/usr/lib/xorg/modules || exit 55
      install -m755 drivers/*.so ${pkgdir}/usr/lib/xorg/modules/drivers
      install -m755 linux/*.so ${pkgdir}/usr/lib/xorg/modules/linux
      install -m755 extensions/fglrx/fglrx-libglx.so ${pkgdir}/usr/lib/xorg/modules/extensions/fglrx/fglrx-libglx.so
      ln -snf /usr/lib/xorg/modules/extensions/fglrx/fglrx-libglx.so ${pkgdir}/usr/lib/xorg/modules/extensions/libglx.so

    # Controlcenter / libraries
      if [ "${ARCH}" = "x86" ]; then
	cd ${srcdir}/ati-catalyst-13/arch/x86/usr
	_lib=lib
      elif [ "${ARCH}" = "x86_64" ]; then
	cd ${srcdir}/ati-catalyst-13/arch/x86_64/usr
	_lib=lib64
      fi

      install -m755 X11R6/bin/* ${pkgdir}/usr/bin
      install -m755 sbin/* ${pkgdir}/usr/bin
      install -m755 X11R6/${_lib}/fglrx/fglrx-libGL.so.1.2 ${pkgdir}/usr/lib/fglrx
      ln -snf /usr/lib/fglrx/fglrx-libGL.so.1.2 ${pkgdir}/usr/lib/fglrx/libGL.so.1.2
      ln -snf /usr/lib/fglrx/fglrx-libGL.so.1.2 ${pkgdir}/usr/lib/fglrx-libGL.so.1.2
      ln -snf /usr/lib/fglrx/fglrx-libGL.so.1.2 ${pkgdir}/usr/lib/libGL.so.1.2
      ln -snf /usr/lib/fglrx/fglrx-libGL.so.1.2 ${pkgdir}/usr/lib/libGL.so.1
      ln -snf /usr/lib/fglrx/fglrx-libGL.so.1.2 ${pkgdir}/usr/lib/libGL.so
      install -m755 X11R6/${_lib}/libAMDXvBA.so.1.0 ${pkgdir}/usr/lib
      ln -snf libAMDXvBA.so.1.0 ${pkgdir}/usr/lib/libAMDXvBA.so.1
      ln -snf libAMDXvBA.so.1.0 ${pkgdir}/usr/lib/libAMDXvBA.so
      install -m755 X11R6/${_lib}/libatiadlxx.so ${pkgdir}/usr/lib
      install -m755 X11R6/${_lib}/libfglrx_dm.so.1.0 ${pkgdir}/usr/lib
      install -m755 X11R6/${_lib}/libXvBAW.so.1.0 ${pkgdir}/usr/lib
      ln -snf libXvBAW.so.1.0 ${pkgdir}/usr/lib/libXvBAW.so.1
      ln -snf libXvBAW.so.1.0 ${pkgdir}/usr/lib/libXvBAW.so
      install -m644 X11R6/${_lib}/*.a ${pkgdir}/usr/lib
      install -m644 X11R6/${_lib}/*.cap ${pkgdir}/usr/lib
      install -m755 X11R6/${_lib}/modules/dri/*.so ${pkgdir}/usr/lib/xorg/modules/dri
      install -m755 ${_lib}/*.so* ${pkgdir}/usr/lib

    ## QT libs (only 2 files) - un-comment 2 lines below if you don't want to install qt package
#      install -m755 -d ${pkgdir}/usr/share/ati/${_lib}
#      install -m755 share/ati/${_lib}/*.so* ${pkgdir}/usr/share/ati/${_lib}

      ln -snf /usr/lib/xorg/modules/dri/fglrx_dri.so ${pkgdir}/usr/lib/dri/fglrx_dri.so
      ln -snf libfglrx_dm.so.1.0 ${pkgdir}/usr/lib/libfglrx_dm.so.1
      ln -snf libfglrx_dm.so.1.0 ${pkgdir}/usr/lib/libfglrx_dm.so
      ln -snf libatiuki.so.1.0 ${pkgdir}/usr/lib/libatiuki.so.1
      ln -snf libatiuki.so.1.0 ${pkgdir}/usr/lib/libatiuki.so
      ln -snf libOpenCL.so.1 ${pkgdir}/usr/lib/libOpenCL.so

      # We have to provide symlinks to mesa, as catalyst doesn't ship them
      ln -s /usr/lib/mesa/libEGL.so.1.0.0 ${pkgdir}/usr/lib/libEGL.so.1.0.0
      ln -s libEGL.so.1.0.0	              ${pkgdir}/usr/lib/libEGL.so.1
      ln -s libEGL.so.1.0.0               ${pkgdir}/usr/lib/libEGL.so

      ln -s /usr/lib/mesa/libGLESv1_CM.so.1.1.0 ${pkgdir}/usr/lib/libGLESv1_CM.so.1.1.0
      ln -s libGLESv1_CM.so.1.1.0	            ${pkgdir}/usr/lib/libGLESv1_CM.so.1
      ln -s libGLESv1_CM.so.1.1.0               ${pkgdir}/usr/lib/libGLESv1_CM.so

      ln -s /usr/lib/mesa/libGLESv2.so.2.0.0 ${pkgdir}/usr/lib/libGLESv2.so.2.0.0
      ln -s libGLESv2.so.2.0.0               ${pkgdir}/usr/lib/libGLESv2.so.2
      ln -s libGLESv2.so.2.0.0               ${pkgdir}/usr/lib/libGLESv2.so

      cd ${srcdir}/ati-catalyst-13/common
      patch -Np2 -i ${srcdir}/arch-fglrx-authatieventsd_new.patch
      install -m644 etc/ati/* ${pkgdir}/etc/ati
      chmod 755 ${pkgdir}/etc/ati/authatieventsd.sh

      install -m644 etc/security/console.apps/amdcccle-su ${pkgdir}/etc/security/console.apps

      install -m755 usr/X11R6/bin/* ${pkgdir}/usr/bin
      install -m644 usr/include/GL/*.h ${pkgdir}/usr/include/GL
      install -m755 usr/sbin/*.sh ${pkgdir}/usr/bin
      install -m644 usr/share/ati/amdcccle/* ${pkgdir}/usr/share/ati/amdcccle
      install -m644 usr/share/icons/*.xpm ${pkgdir}/usr/share/pixmaps
      install -m644 usr/share/man/man8/*.8 ${pkgdir}/usr/share/man/man8
      install -m644 usr/share/applications/*.desktop ${pkgdir}/usr/share/applications

    # ACPI example files
      install -m755 usr/share/doc/fglrx/examples/etc/acpi/*.sh ${pkgdir}/etc/acpi
      sed -i -e "s/usr\/X11R6/usr/g" ${pkgdir}/etc/acpi/ati-powermode.sh
      install -m644 usr/share/doc/fglrx/examples/etc/acpi/events/* ${pkgdir}/etc/acpi/events

    # Add ATI Events Daemon launcher
      install -m755 ${srcdir}/atieventsd.sh ${pkgdir}/etc/rc.d/atieventsd
      install -m644 ${srcdir}/atieventsd.service ${pkgdir}/usr/lib/systemd/system

    # thanks to cerebral, we dont need that damned symlink
      install -m755 ${srcdir}/catalyst.sh ${pkgdir}/etc/profile.d

    # License
      install -m644 ${srcdir}/ati-catalyst-13/LICENSE.TXT ${pkgdir}/usr/share/licenses/${pkgname}
      install -m644 ${srcdir}/ati-catalyst-13/common/usr/share/doc/amdcccle/ccc_copyrights.txt \
	${pkgdir}/usr/share/licenses/${pkgname}/amdcccle_copyrights.txt

    # since 11.11 : opencl files
      if [ "${ARCH}" = "x86" ]; then
	cd ${srcdir}/ati-catalyst-13/arch/x86
	_arc=32
      elif [ "${ARCH}" = "x86_64" ]; then
	cd ${srcdir}/ati-catalyst-13/arch/x86_64
	_arc=64
      fi

      install -m644 etc/OpenCL/vendors/amdocl${_arc}.icd ${pkgdir}/etc/OpenCL/vendors
      install -m755 usr/bin/clinfo ${pkgdir}/usr/bin
      install -m755 -d ${pkgdir}/etc/modules-load.d
      install -m644 ${srcdir}/catalyst.conf ${pkgdir}/etc/modules-load.d

echo "Buildt"
touch ${srcdir}/ati-catalyst-13/buildok-x86_64
