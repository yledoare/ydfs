cd $HOME

if [ -e $HOME/.local/share/Steam/ ]
then

# sed -i "s@LD_LIBRARY_PATH@DISABLE_LINUXCONSOLE@g" $HOME/.local/share/Steam/steam.sh
# echo ' ' > $HOME/.local/share/Steam/steamdeps.txt

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/share/Steam/ubuntu12_32" 
echo "DEBUG : $LD_LIBRARY_PATH" && sleep 5 
export LIBGL_DRIVERS_PATH=/usr/lib32/dri/ 
# $HOME/.local/share/Steam/steam.sh
LD_LIBRARY_PATH="/home/yann/.local/share/Steam/ubuntu12_32/:/home/linuxconsole2019/multilib/lib:$LD_LIBRARY_PATH"  /home/yann/.local/share/Steam/ubuntu12_32/steam
# /home/yann/.local/share/Steam/ubuntu12_32/steam

else

install -d src/steam
cd src/steam
[ ! -e steam-launcher ] && wget http://repo.steampowered.com/steam/pool/steam/s/steam/steam_1.0.0.62.tar.gz && tar xzvf steam_1.0.0.62.tar.gz
# sed -i "s@id -u@echo@g" steam/steam
# mkdir bootstrap
# cd bootstrap
# tar xJvf ../steam/bootstraplinux_ubuntu12_32.tar.xz
#echo '
#STEAM_RUNTIME=1
#STEAM_DEPENDENCY_VERSION=1' > steamdeps.txt
#sed -i "s@LD_LIBRARY_PATH@DISABLE_LINUXCONSOLE@g" steam.sh
#tar cJvf ../steam/bootstraplinux_ubuntu12_32.tar.xz *
# cd ..
cd steam-launcher && DESTDIR=/tmp make install
#LIBGL_DRIVERS_PATH=/usr/lib32/dri/ steam/steam

fi
