echo '

KERNEL!="sr[0-9]", GOTO="media_by_label_auto_mount_cdrom_end"

SUBSYSTEM=="block", KERNEL=="sr0", RUN+="/busybox/bin/mkdir -p /media/cdrom"
IMPORT{program}="/usr/sbin/blkid -o udev -p %N"
ENV{ID_FS_LABEL}!="", ENV{dir_name}="%E{ID_FS_LABEL}"
RUN+="/busybox/bin/mkdir -p /media/%E{dir_name}" RUN+="/busybox/bin/mount  /dev/%k /media/%E{dir_name}" , RUN+="/busybox/bin/mount -o $env{mount_options} /dev/%k /media/%E{dir_name}"

LABEL="media_by_label_auto_mount_cdrom_end"

' > /usr/libexec/rules.d/12-media-by-label-auto-mountcdrom.rules
udevadm control --reload-rules