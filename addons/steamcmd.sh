install -d $HOME/src/steam
cd $HOME/src/steam
[ ! -e steamcmd_linux.tar.gz ] && wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
[ ! -e linux32 ] && tar xzvf steamcmd_linux.tar.gz

if [ ! -e ~/.steam ]
then
    mkdir -p ~/.steam/appcache/
    mkdir -p ~/.steam/config/
    mkdir -p ~/.steam/logs/
    mkdir -p ~/.steam/SteamApps/common/
    ln -s ~/.steam ~/.steam/root
    ln -s ~/.steam ~/.steam/steam
fi

if [ ! -e ~/.steam/steamcmd ]
then
    mkdir -p ~/.steam/steamcmd/linux32
    # steamcmd will replace these files with newer ones itself on first run
    cp steamcmd.sh ~/.steam/steamcmd/steamcmd.sh
    cp linux32/steamcmd ~/.steam/steamcmd/linux32/steamcmd
fi

exec ~/.steam/steamcmd/steamcmd.sh $@
