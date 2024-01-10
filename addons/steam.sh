cd $HOME

if [ ! -e $HOME/.local/share/Steam/ ]
then

install -d src/steam
cd src/steam
[ ! -e steam-launcher ] && wget http://repo.steampowered.com/steam/pool/steam/s/steam/steam_1.0.0.78.tar.gz && tar xzvf steam_1.0.0.78.tar.gz
cd steam-launcher && ./steam 

fi

export LD_LIBRARY_PATH="$HOME/.local/share/Steam/ubuntu12_32/:$HOME/src/ydfs/addons/lib:/usr/lib32:$HOME/.local/share/Steam/ubuntu12_32/steam-runtime/pinned_libs_32:$HOME/.local/share/Steam/ubuntu12_32/steam-runtime/usr/lib/i386-linux-gnu/:$HOME/.local/share/Steam/ubuntu12_32/steam-runtime/lib/i386-linux-gnu:$HOME/.local/share/Steam/ubuntu12_32/steam-runtime/usr/lib/i386-linux-gnu/gio/modules/:$LD_LIBRARY_PATH:$HOME/.local/share/Steam/ubuntu12_32" 
echo "DEBUG : $LD_LIBRARY_PATH" && sleep 5 
export LIBGL_DRIVERS_PATH=/usr/lib32/dri/ 
export STEAM_RUNTIME=0
export STEAM_RUNTIME_HEAVY=0
export DBUS_FATAL_WARNINGS=0
$HOME/.local/share/Steam/ubuntu12_32/steam

