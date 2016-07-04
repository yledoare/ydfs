THEHOME=`ls /home`
if [ ! -e "/home/$THEHOME/$ARCH/var/lib/alsa" ] 
then
  install -d /home/$THEHOME/$ARCH/var/lib/alsa
  ln -s /home/$THEHOME/$ARCH/var/lib /home/$THEHOME/var/lib
  alsactl store
else
  ln -s /home/$THEHOME/$ARCH/var/lib /home/$THEHOME/var/lib
  alsactl restore
fi

echo "alsactl store" >> /ydfs/start/save-persistant-data
