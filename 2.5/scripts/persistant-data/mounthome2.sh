if [ ! -e /disk/root.ext3 ]
then
  echo "#################### INIT PERSISTANT DATA ###############"
  dd if=/dev/zero of=/disk/root.ext3 bs=1M count=300
  echo "#################### RUN MKE2FS ###############"
  mke2fs -F -j /disk/root.ext3 
  echo "#################### MKE2FS OK ###############"
fi

mount /disk/root.ext3 /root

install -d /etc/NetworkManager/system-connections
if [ -e /disk/system-connections/ ]
then
  cp /disk/system-connections/* /etc/NetworkManager/system-connections/
  chmod 500 /etc/NetworkManager/system-connections/*
fi

mount /etc/NetworkManager/ /home/ydfs-32/x86/etc/NetworkManager -o bind

install -d /disk/system-connections/
echo "cp /etc/NetworkManager/system-connections/* /disk/system-connections/" >> /ydfs/start/xorg
