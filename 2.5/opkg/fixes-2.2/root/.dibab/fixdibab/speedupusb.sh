echo '
KERNEL!="sd[a-z][0-9]", GOTO="media_by_label_auto_mount_end"

# Import FS infos
IMPORT{program}="/usr/sbin/blkid -o udev -p %N"

# Get a label if present, otherwise specify one
ENV{ID_FS_LABEL}!="", ENV{dir_name}="%E{ID_FS_LABEL}"
ENV{ID_FS_LABEL}=="", ENV{dir_name}="usbhd-%k"

# Global mount options
ACTION=="add", ENV{mount_options}="relatime"
# Filesystem-specific mount options
#ACTION=="add", ENV{ID_FS_TYPE}="ntfs",  RUN+="/busybox/bin/mkdir -p /media/%E{dir_name}", RUN+="/usr/bin/ntfs-3g  /dev/%k /media/%E{dir_name}"
# Mount the device
#ACTION=="add", ENV{ID_FS_TYPE}!="ntfs", RUN+="/busybox/bin/mkdir -p /media/%E{dir_name}", RUN+="/busybox/bin/mount -o $env{mount_options} /dev/%k /media/%E{dir_name}"
 ACTION=="add", RUN+="/busybox/bin/mkdir -p /media/%E{dir_name}" RUN+="/usr/bin/ntfs-3g  /dev/%k /media/%E{dir_name}" , RUN+="/busybox/bin/mount -o $env{mount_options} /dev/%k /media/%E{dir_name}"

# Clean up after removal
ACTION=="remove", ENV{dir_name}!="", RUN+="/busybox/bin/umount -l /media/%E{dir_name}", RUN+="/busybox/bin/rmdir /media/%E{dir_name}"

# Exit
LABEL="media_by_label_auto_mount_end"

' > /usr/libexec/rules.d/11-media-by-label-auto-mount.rules
udevadm control --reload-rules
