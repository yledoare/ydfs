#cp /etc/NetworkManager/system-connections/*
#sh

if [ ! -e /media/ydfs/ydfs/root.ext3 ]
then
  install -d  /media/ydfs/ydfs/
  echo "#################### INIT PERSISTANT DATA ###############"
  dd if=/dev/zero of=/media/ydfs/ydfs/root.ext3 bs=1M count=100
  echo "#################### RUN MKE2FS ###############"
  mke2fs -F -j /media/ydfs/ydfs/root.ext3 
  echo "#################### MKE2FS OK ###############"
fi

mount /media/ydfs/ydfs/root.ext3 /root

install -d /etc/NetworkManager/system-connections
if [ -e /media/ydfs/ydfs/system-connections/ ]
then
  cp /media/ydfs/ydfs/system-connections/* /etc/NetworkManager/system-connections/
  chmod 500 /etc/NetworkManager/system-connections/*
fi

mount /etc/NetworkManager/ /home/ydfs-32/x86/etc/NetworkManager -o bind

install -d /media/ydfs/ydfs/system-connections/
echo "cp /etc/NetworkManager/system-connections/* /media/ydfs/ydfs/system-connections/" >> /ydfs/start/xorg
