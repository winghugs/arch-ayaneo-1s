# arch-ayaneo-1s

INCOMPLETE - still working on stuff, just taking notes here

Arch Installer:
* Best effort partition scheme works, I use 
* Enable Multilib
* Use GRUB
* Enable Bluetooth
* Enable Pipewire Audio
* Use Desktop setup with desktop of choice, but use SDDM as greeter.

After Arch installer:
* Create a mountpoint for the SD card on the filesystem and add it to fstab.
 * Add nofail to the SD card entry
* Run scripts (arch-deckify, sdgyrodsu (optional), deckyloader, deckyplumber, simpledeckytdp)
* Move the correct firmware into /usr/lib/firmware. The AUR package firmware no longer works, need the firmware from SteamFork or this repo.
* Install and use ChimeraOS linux kernel
* (optional) Add capability map to flip ayaneo button and start
* Add brightness udev rule
* Install packages
* (optional) Add audio modprobe rule to prevent popping


***** OLD ******

- Downgrade bluez to 5.68 if you want bluetooth controllers to connect properly
- From https://github.com/chimeraos/device-quirks:
  - firmware from /usr/lib/firmware/edid/
  - air service file for audio fix
- From https://github.com/steamfork/distribution
  - linux patches
  - linux-firmware
- Install DeckyPlumber `curl -L https://github.com/aarron-lee/DeckyPlumber/raw/main/install.sh | sh`
- Install SimpleDeckyTDP `curl -L https://github.com/aarron-lee/SimpleDeckyTDP/raw/main/install.sh | sh`
- Add to /etc/modprobe.d/audio.conf `options snd_hda_intel power_save=0 power_save_controller=N` - eliminates popping sound when speakers turn on. Put it to 1 and Y if you want slightly better battery.
- Add udev rule for brightness: `ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"`

The desktop mode button in SteamOS calls specifically "/usr/bin/steamos-session-select plasma" - do with that what you want to start your session. I have a lightdm session that calls a script to start session from my user directory, so I don't have to do sudo nonsense to change what the autologin selects. I'll upload it all here eventually. You can create whatever as a .desktop file outside of game mode so I don't bother handling the "steamos-session-select gamescope" command, just end the desktop session after setting autologin back to gamescope in lightdm.

Gamescope needs to be gamescope-plus specifically so the -e flag will work. This allows for things like opengamepadui to run.
