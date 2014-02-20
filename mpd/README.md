# Configuring MPD
## Stop the system level service
* By default, MPD installs as a system-level service. But, you want it running in
userspace. `sudo service mpd stop && sudo update-rc.d mpd disable`

## Create the configuration filestructure
* Make a folder first: `mkdir ~/.mpd/playlists`
* Then create the necessary files: `touch ~/.mpd/{mpd.db,mpd.log,mpd.pid,mpdstate}`
* Lastly, link the config file: `ln -s ~/dotfiles/mpd/mpd.conf ~/.mpd/mpd.conf`
