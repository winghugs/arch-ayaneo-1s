#!/bin/bash
#REPOSITORY AT: https://github.com/winghugs/arch-ayaneo-1s

#shouldn't run as sudo
if [ $(id -u) -eq 0 ]
  then echo "Please do not run this script with sudo or as root, run as your user account."
  exit
fi

#initial warnings
clear
echo "-----READ THIS-----"
echo "This script is interactive and will ask for information occassionally. Please stick around during the install for the occassional password input or choice. Please also read the notes at the end to complete installation. This is not intended to be a one and done solution, only to simplify the process for those with an already passing familiarity with Arch."
echo "This script also assumes you are running a fresh install of Arch, with the desktop of your choice installed as well as SDDM for the greeter. This script will install SDDM, but if another greeter was installed, you will need to manually swap it over."
echo "This script will modify system configurations, files, and setings. In some cases it could cause system instability, configuration loss, or make the system unbootable. Especially if you aren't running the configuration specified on the github page (https://github.com/winghugs/arch-ayaneo-1s), you may encounter issues."
echo "You can exit the script by closing the terminal window or pressing CTRL+C"
echo "-----"
echo "To be installed:"
echo "Base Repos: steam, inputplumber, vim, git, gamemode, rsync, 7zip, jq"
echo "AUR: ayaneo-platform-dkms-git, ryzenadj"
echo "Firmware: aw87xxx_acf (older version)"
echo "Custom: Arch-Deckify, DeckyLoader, DeckyPlumber, SimpleDeckyTDP, linux-chimeraos"
echo "-----"
echo "Press any key to continue, or CTRL+C to exit"
read -n 1
clear

#go to home directory
cd /home/$USER
dir=$('pwd')

#user needs to be in input group
sudo usermod -a -G input $USER

sudo pacman -Syyu git --noconfirm
mkdir tmp_bootstrap
cd tmp_bootstrap

#getting aur manager installed
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd $dir/tmp_bootstrap

#grabbing files from repo for firmware install
git clone https://github.com/winghugs/arch-ayaneo-1s
cd arch-ayaneo-1s
sudo cp aw87xxx_acf.bin /usr/lib/firmware
sudo cp aw87xxx_acf.bin.zst /usr/lib/firmware
cd $dir/tmp_bootstrap

#grabbing and installing the latest release of chimeraos kernel
mkdir kernel
cd kernel
curl -sL https://api.github.com/repos/ChimeraOS/linux-chimeraos/releases/latest | jq -r '.assets[] | .browser_download_url' | xargs -n 1 wget
sudo pacman -U *
cd $dir

#grab and enable everything else we need to set up as a baseline
yay -S steam inputplumber vim gamemode rsync 7zip jq ayaneo-platform-dkms-git ryzenadj --noconfirm --sudoloop
sudo systemctl enable inputplumber

#various install scripts
curl -sSL https://raw.githubusercontent.com/unlbslk/arch-deckify/refs/heads/main/install.sh > deckify_install.sh && bash deckify_install.sh; rm -rf deckify_install.sh
curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh
curl -L https://github.com/aarron-lee/SimpleDeckyTDP/raw/main/install.sh | sh
curl -L https://github.com/aarron-lee/DeckyPlumber/raw/main/install.sh | sh

#setup brightness rule
cd $dir/tmp_bootstrap/arch-ayaneo-1s
sudo cp 99-brightness.rules /etc/udev/rules.d/

#rebuild kernel just in case
sudo mkinitcpio -p linux-chimeraos
cd $dir

#leave no evidence >:D
rm -r tmp_bootstrap
clear
echo "----- POST INSTALL -----"
echo "Reboot your system, selecting the ChimeraOS kernel on boot."
echo "Run 'uname -r' after boot to ensure that the kernel is running. It should say 'chos' somewhere in the output."
echo "You may need to run the DeckyLoader install again if it doesn't show up. You can find a one liner to install it both on this repo's github and the DeckyLoader github"
echo "Please launch the new game mode icon to switch into gaming mode. You will need to ensure your console is not plugged into an external display for switching."
echo "-----"
echo ""
read -n 1
exit
