# arch-ayaneo-1s

### Arch Installer:
* Immediately type `dmesg -n 1` to kill the error messages
* If you need wifi - `iwctl` and then `station wlan0 connect <SSID` - CTRL+D to get out after connected
* Best effort partition scheme works, I use ext4
* Enable Multilib
* Use whatever bootloader you want, but know how to switch to a new kernel if you're not using systemd-boot.
* Enable Bluetooth
* Enable Pipewire Audio
* Use Desktop setup with desktop of choice, but use SDDM as greeter.

### Scripted Install
One liner to get everything set up, read everything that is prompted: `curl -sSL https://raw.githubusercontent.com/winghugs/arch-ayaneo-1s/refs/heads/main/bootstrap.sh > bootstrap.sh && bash bootstrap.sh; rm -rf deckify_install.sh`

### Manual install steps
### After Arch installer:
* Create a mountpoint for the SD card on the filesystem and add it to fstab. Add nofail to the SD card entry
* Run scripts (arch-deckify, sdgyrodsu (optional), deckyloader, deckyplumber, simpledeckytdp)
* Enable inputplumber
* Enable bluetooth
* Move the correct firmware into /usr/lib/firmware. The AUR package firmware no longer works, need the firmware from SteamFork (or this repo.)
* Install and use ChimeraOS linux kernel
* (optional) Add capability map to flip ayaneo button and start
* Add brightness udev rule
* Install packages
* (optional) Add audio modprobe rule to prevent popping. `options snd_hda_intel power_save=0 power_save_controller=N`
* Change GRUB entry to use ChimeraOS
* Edit /etc/systemd/logind.conf. Uncomment and change HandlePowerOff to `HandlePowerOff=suspend`

### Extra Info:
* arch-deckify: `curl -sSL https://raw.githubusercontent.com/unlbslk/arch-deckify/refs/heads/main/install.sh > deckify_install.sh && bash deckify_install.sh; rm -rf deckify_install.sh` 
* DeckyLoader: `curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh` 
* DeckyPlumber: `curl -L https://github.com/aarron-lee/DeckyPlumber/raw/main/install.sh | sh` 
* SimpleDeckyTDP: `curl -L https://github.com/aarron-lee/SimpleDeckyTDP/raw/main/install.sh | sh` 
* Brightness - to /etc/udev/rules.d/99-brightness.rules: `ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"`
* Audio Popping - to /etc/modprobe.d/audio.conf: `options snd_hda_intel power_save=0 power_save_controller=N`
