[ ! -e initramfs ] && cp /media/ydfs/initramfs .
if [ ! -e rootfs ]
then
  mkdir rootfs
  cd rootfs
  cpio -idv < ../initramfs
fi


if [ ! -e rootfs/drivers ]
then
  mkdir rootfs/drivers
  find /lib/modules/4.4.19/kernel/drivers/net/ -name *.ko | while read file; do cp $file rootfs/drivers ; done
fi

echo
