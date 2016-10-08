[ "$1" == "" ] && exit 1
NAME=$1

echo "
[Desktop Entry]
Version=1.0
Name=$NAME
Exec=/ydfs/add/software $NAME
Terminal=false
Icon=$NAME
Type=Application
Categories=Install " > usr/share/applications/install-$NAME.desktop
