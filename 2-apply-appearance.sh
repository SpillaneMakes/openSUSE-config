# Define home directory path from sudo user
USR_HOME="$(getent passwd $SUDO_USER | cut -d: -f6)"

# Create wallpaper plugin directory
cd $USR_HOME/.local/share
if [ ! -d "./plasma/wallpapers/" ]; then
    mkdir -p "./plasma/wallpapers"
fi
cd plasma/wallpapers/

# Clone flipclock wallpaper plugin
git clone https://invent.kde.org/davidedmundson/flipclock.git

# Set wallpaper plugin to flipclock
kwriteconfig5 --file $USR_HOME/.config/plasma-org.kde.plasma.desktop-appletsrc \
              --group Containments --group "1" \
              --key wallpaperplugin flipclock


# Create Plasma JS Script
cd $USR_HOME/Desktop/
touch taskbar-panel.js

# Populate file with taskbar script
echo -e '
// Remove Default Bottom Panel
const defaultPanel = panelIds
panelById(defaultPanel).remove()

// Create new Custom Panel
const panel = new Panel
panel.location = "bottom";
panel.height = Math.round(gridUnit * 1.75);

panel.addWidget("org.kde.plasma.marginsseparator");
panel.addWidget("org.kde.plasma.kickoff");
panel.addWidget("org.kde.plasma.showdesktop");
panel.addWidget("org.kde.plasma.showActivityManager");
panel.addWidget("org.kde.plasma.systemmonitor.net");
panel.addWidget("org.kde.plasma.systemmonitor.cpucore");
panel.addWidget("org.kde.plasma.panelspacer");
panel.addWidget("org.kde.plasma.icontasks");
panel.addWidget("org.kde.plasma.panelspacer");
panel.addWidget("org.kde.plasma.timer");
panel.addWidget("org.kde.plasma.colorpicker");
panel.addWidget("org.kde.plasma.systemtray");
panel.addWidget("org.kde.plasma.digitalclock");
panel.addWidget("org.kde.plasma.marginsseparator");
' >> taskbar-panel.js

# Move JS script to the script update queue
mv taskbar-panel.js /usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/


# Move to Color Scheme Directory
cd /usr/share/color-schemes/

# Download Popular Themes
wget https://gitlab.manjaro.org/artwork/themes/breath/-/raw/master/colors/BreathLight.colors
wget https://gitlab.manjaro.org/artwork/themes/breath/-/raw/master/colors/BreathDark.colors
wget https://raw.githubusercontent.com/EliverLara/Nordic/master/kde/colorschemes/nordicbluish.colors
wget https://raw.githubusercontent.com/EliverLara/Nordic/master/kde/colorschemes/Nordic.colors

# Change Color Scheme
kwriteconfig5 --file $USR_HOME/.config/kdeglobals \
              --group General \
              --key ColorScheme BreathDark
