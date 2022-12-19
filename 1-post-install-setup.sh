# Change the static hostname
hostnamectl set-hostname 'precision5750'

# Add /home subvolume to Snapper
snapper -c home create-config /home

# Take a snapshot before configuring fresh install
snapper -c home create -d "home/ before packman config"
snapper -c root create -d "root/ before packman config"


# Add community repository
zypper --gpg-auto-import-keys addrepo -fp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman

# Add nvidia repository
zypper --gpg-auto-import-keys addrepo -f https://download.nvidia.com/opensuse/tumbleweed nvidia

# Refresh repositories and Update the distribution
zypper --gpg-auto-import-keys refresh
zypper -n dup --allow-vendor-change


# Install system utilities, Core Microsoft Fonts, and Media Codecs
zypper -n in \
	flatpak htop iotop neofetch fetchmsttfonts \
	ffmpeg vlc-codecs gstreamer-plugins-{ugly,libav}

# Install recommended graphics drivers
zypper install-new-recommends --repo nvidia

# Add flathub remote repository to flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# Lower swappiness value for better performance
echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf
# cat /proc/sys/vm/swappiness

# Reload system variables
sysctl --system


# Print completed script output
hstnm=$(hostnamectl | grep "Static hostname:")
swpi=$(cat /proc/sys/vm/swappiness)
echo "	$hstnm"
echo " 	 Swappiness: $swpi"

neofetch

zypper lr -P

echo "	********* Script Completed *********	"
