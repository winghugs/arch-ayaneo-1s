# arch-ayaneo-1s

INCOMPLETE - still working on stuff, just taking notes here

- Downgrade bluez to 5.68 if you want bluetooth controllers to connect properly
- From https://github.com/chimeraos/device-quirks:
    firmware from /usr/lib/firmware/edid/
    air service file for audio fox
- From https://github.com/steamfork/distribution
    linux patches
    linux-firmware
- Install DeckyPlumber `curl -L https://github.com/aarron-lee/DeckyPlumber/raw/main/install.sh | sh`
- Install SimpleDeckyTDP `curl -L https://github.com/aarron-lee/SimpleDeckyTDP/raw/main/install.sh | sh`
- Add to /etc/modprobe.d/audio.conf `options snd_hda_intel power_save=0 power_save_controller=N` - eliminates popping sound when speakers turn on. Put it to 1 and Y if you want slightly better battery.
- (need to add brightness udev rule to readme)

The desktop mode button in SteamOS calls specifically "/usr/bin/steamos-session-select plasma" - do with that what you want to start your session. I have a lightdm session that calls a script to start session from my user directory, so I don't have to do sudo nonsense to change what the autologin selects. I'll upload it all here eventually. You can create whatever as a .desktop file outside of game mode so I don't bother handling the "steamos-session-select gamescope" command, just end the desktop session after setting autologin back to gamescope in lightdm.

Gamescope needs to be gamescope-plus specifically so the -e flag will work. This allows for things like opengamepadui to run.
