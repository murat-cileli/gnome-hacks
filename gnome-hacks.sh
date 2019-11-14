#!/bin/bash

hideClock=true
darkTheme=( "kdenlive" "phpstorm" "krita" "gimp" )

if [[ $hideClock == true ]]; then
    dbus-send --session --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval string:'Main.panel.statusArea.dateMenu.actor.hide();'
fi

oldId=0

while true
do
    sleep 3s;

    id="$(nice -n10 xdotool getwindowfocus)"

    if [[ $oldId == $id ]]; then
        continue
    fi

    class="$(nice -n10 xprop -id $(xdotool getwindowfocus) | grep WM_CLASS)"

    for i in "${darkTheme[@]}"
    do
        if [[ $class == *"$i"* ]]; then
           nice -n10 xprop -id $id -f _GTK_THEME_VARIANT 8u -set _GTK_THEME_VARIANT "dark"
        fi
    done

    oldId=$id
done

