# Change the static hostname
hostnamectl set-hostname 'dspil'

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

# Add remote repository to flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# Install Git, Neofetch, Core Microsoft Fonts, and Media Codecs
zypper -n in neofetch fetchmsttfonts ffmpeg gstreamer-plugins-{ugly,libav} vlc-codecs

# Install recommended graphics drivers
zypper install-new-recommends --repo nvidia


# Lower swappiness value for better performance
echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf
# cat /proc/sys/vm/swappiness

# Reload system variables
sysctl --system


echo """	********* Script Completed *********	"""

hstnm=$(hostnamectl | grep "Static hostname:")
swpi=$(cat /proc/sys/vm/swappiness)
echo "	$hstnm"
echo " 	 Swappiness: $swpi"

neofetch

zypper lr -P
