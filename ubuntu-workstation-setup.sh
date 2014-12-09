# ppas
sudo add-apt-repository ppa:launchpad
sudo add-apt-repository ppa:bzr
sudo apt-get update

# packages
sudo apt-get install -y --no-install-recommends emacs keepassx gnome-tweak-tool chromium-browser tmux vlc virtualbox lxc packaging-dev irssi xclip virtualenv virtualenvwrapper libimobiledevice-utils bzr bzr-pqm htop libssl-dev tree

# rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build/

# dropbox
cd ~ && wget https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.2_amd64.deb
sudo dpkg -i dropbox_1.6.2_amd64.deb
dropbox start -i
dropbox autostart y
echo fs.inotify.max_user_watches=100000|sudo tee -a /etc/sysctl.conf; sudo sysctl -p

# spotify
sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free" &&
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 &&
sudo apt-get update -qq &&
sudo apt-get install spotify-client
