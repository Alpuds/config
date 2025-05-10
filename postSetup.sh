#!/bin/sh

# Run this script as a regular user after using LARBS.

# This script copies files into their appropriate directories
# as well as setting them up to make them work.
# Specifically these kind of files:
# - Pacman hooks
# - SystemD services
# - Udev rules

boldCyanTxt='\033[1;36m'
boldYellowTxt='\033[1;32m'
colorEND='\033[0m' # Makes the text be regular

heading(){
    echo "${boldCyanTxt}${1}$colorEND"
}

heading "Installing wallpapers"
cd ${HOME}/.local/share
tar -xvf ${HOME}/.local/share/wallpapers.tar
rm ${HOME}/.local/share/wallpapers.tar
ln -sf ${HOME}/.local/share/wallpapers/landscapes/forestWaterFall.jpg bg
heading "Setting wallpaper"
setbg

heading "Copying udev rules"
sudo cp ./udevRules/*.rules /etc/udev/rules.d

heading "Reloading udev rules"
sudo udevadm control --reload-rules
sudo udevadm trigger

heading "Copying Pacman hooks"
sudo cp ./pacmanHooks/*.hook /usr/share/libalpm/hooks

heading "Copying keyd config"
sudo cp ./.config/keyd/default.conf /etc/keyd/

heading "Enabling Systemd units"
sudo systemctl enable --now keyd
systemctl enable --user --now waybar

echo "${boldYellowTxt}Reminders${colorEND}:"
cat << END
- Put lat long for wlsunset in the hyprland config file:
${HOME}/.config/hypr/execs.conf

END

heading "The post script finished."
