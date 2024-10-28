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

# Reminder flags
remindGPU=false

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

heading "Xorg GPU config"
read -p 'Make an AMD GPU Xorg config? [y/N]: ' ans
if [ $ans = 'y' ]; then
    heading "Making an AMD GPU config"
    sudo tee /etc/X11/xorg.conf.d/20-amdgpu.conf << END >/dev/null
Section "Device"
     Identifier "AMD"
     Driver "amdgpu"
     Option "TearFree" "true"
EndSection
END
unset remindGPU
else
    heading "Skipping Xorg GPU config."
    remindGPU=true
fi

heading "Copying udev rules"
sudo cp ./udevRules/*.rules /etc/udev/rules.d

heading "Reloading udev rules"
sudo udevadm control --reload-rules
sudo udevadm trigger

heading "Copying Pacman hooks"
sudo cp ./pacmanHooks/*.hook /usr/share/libalpm/hooks

heading "Copying SystemD services"
sudo cp ./systemdServices/*.service /etc/systemd/system

heading "Setting up betterlockscreen"
betterlockscreen -u ${HOME}/.local/share/wallpapers/landscapes/forestBridgeFall.jpg
echo "${boldYellowTxt}In ${boldCyanTxt}10 seconds${boldYellowTxt}, the lockscreen will activate.$colorEND"
sleep 10 | pv
sudo systemctl enable --now betterlockscreen@${USER}.service

echo "${boldYellowTxt}Reminders${colorEND}:"
cat << END
- Put your location (zip) in the Redshift config file:
${HOME}/.config/redshift/redshift.conf

END

[ $remindGPU = true ] && echo '- Look into configuring the GPU(s) of the computer.\n'
heading "The post script finished."
