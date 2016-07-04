#cp /etc/NetworkManager/system-connections/*
#sh

if [ ! -e /media/dibab/dibab/root.ext3 ]
then
  install -d  /media/dibab/dibab/
  echo "#################### INIT PERSISTANT DATA ###############"
  dd if=/dev/zero of=/media/dibab/dibab/root.ext3 bs=1M count=100
  echo "#################### RUN MKE2FS ###############"
  mke2fs -F -j /media/dibab/dibab/root.ext3 
  echo "#################### MKE2FS OK ###############"
fi

mount /media/dibab/dibab/root.ext3 /root

install -d /etc/NetworkManager/system-connections
if [ -e /media/dibab/dibab/system-connections/ ]
then
  cp /media/dibab/dibab/system-connections/* /etc/NetworkManager/system-connections/
  chmod 500 /etc/NetworkManager/system-connections/*
fi

mount /etc/NetworkManager/ /home/dibab-32/x86/etc/NetworkManager -o bind

install -d /media/dibab/dibab/system-connections/
echo "cp /etc/NetworkManager/system-connections/* /media/dibab/dibab/system-connections/" >> /dibab/start/xorg
