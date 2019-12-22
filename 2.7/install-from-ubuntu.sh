ROOTFS=`mount |grep ext4|cut -d' ' -f1|head -1`

e2label $ROOTFS linuxconsole || exit 1

ISO=linuxconsole.2019-x86_64.iso
[ ! -e "$ISO" ] && wget http://jukebox.linuxconsole.org/official/$ISO
[ ! -e "$ISO" ] && echo "You need $ISO" && exit 1

install -d /media/iso
mount $ISO /media/iso || exit 1

cp /media/iso/isolinux/kernel /boot/vmlinuz-4-linuxconsole || exit 1
cp /media/iso/isolinux/initramfs /boot/initrd.img-4-linuxconsole || exit 1
cp -fR /media/iso/modules/ / || exit 1

update-grub
touch /syslinux.cfg

umount /media/iso
