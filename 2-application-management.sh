# Define home directory path from sudo user
USR_HOME="$(getent passwd $SUDO_USER | cut -d: -f6)"

cd $USR_HOME


# Uninstall unnecessary Packages
zypper -n rm -u konversation opensuse-welcome kcm_tablet
zypper -n rm -u digikam tigervnc xscreensaver
zypper -n rm discover


# Add Microsoft repositories
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper ar -fp 80 https://packages.microsoft.com/yumrepos/vscode vscode

# Add Sublime text repository
rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
zypper ar -g -fp 80 https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

# Refresh repositories
zypper --gpg-auto-import-keys refresh


# Install packages/apps
zypper -n in \
	nodejs-default code sublime-text sublime-merge podman \
	filelight gparted qbittorrent rpi-imager kdeconnect-kde \
	inkscape blender PrusaSlicer virtualbox

# Update system and packages
zypper -n dup --allow-vendor-change


# Install Flatpaks
flatpak install -y flathub \
	md.obsidian.Obsidian \
	com.bitwarden.desktop \
	com.discordapp.Discord \
	de.haeckerfelix.Shortwave \
	com.github.tchx84.Flatseal \
	com.getpostman.Postman \
	org.ferdium.Ferdium \
	com.spotify.Client \
	net.meshlab.MeshLab \


# Define file type associations
xdg-mime default sublime_text.desktop text/plain
xdg-mime default sublime_text.desktop text/markdown

neofetch

echo " ********* Script Completed ********* "
