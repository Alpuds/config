#!/bin/sh

helpMsg(){
    cat << END
Usage: wm-swap OPTION

Swap the window manager being launched upon login
and print the current window manager.

-h      Show this help text and exit the script
END
}

[ "$1" = '-h' ] && helpMsg && exit 1

grep -q 'dwm$' xinitrc && rcDwm=true

if [ "$rcDwm" = true ]; then
    mv xinitrc xinitrc-dwm
    mv xinitrc-awesome xinitrc
    echo 'current xinitrc: awesome'
else
    mv xinitrc xinitrc-awesome
    mv xinitrc-dwm xinitrc
    echo 'current xinitrc: dwm'
fi
