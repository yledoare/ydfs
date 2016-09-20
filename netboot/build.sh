[ ! -e initramfs ] && cp /media/ydfs/initramfs .
if [ ! -e rootfs ]
then
  mkdir rootfs
  cd rootfs
  cpio -idv < ../initramfs
fi
echo
