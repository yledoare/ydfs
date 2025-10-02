echo 'Section "InputClass"
        Identifier "joystick catchall"
        MatchIsJoystick "on"
        MatchDevicePath "/dev/input/event*"
        Driver "joystick"
        Option "StartKeysEnabled" "False"
#        Option "StartMouseEnabled" "False"
EndSection ' > /etc/X11/xorg.conf.d/js.conf
