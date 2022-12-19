# Define home directory path from sudo user
USR_HOME="$(getent passwd $SUDO_USER | cut -d: -f6)"

cd $USR_HOME

# Create wallpaper plugin directory
if [ ! -d "./.local/share/plasma/wallpapers/" ]; then
    mkdir -p "./.local/share/plasma/wallpapers"
fi
cd ./.local/share/plasma/wallpapers

# Clone flipclock wallpaper plugin
git clone https://invent.kde.org/davidedmundson/flipclock.git

# Set wallpaper plugin to flipclock
kwriteconfig5 --file plasma-org.kde.plasma.desktop-appletsrc \
			  --group Containments --group "1" \
			  --key wallpaperplugin flipclock


# Download color schemes to color-schemes directory
cd /usr/share/color-schemes/
wget https://gitlab.manjaro.org/artwork/themes/breath/-/raw/master/colors/BreathLight.colors
wget https://gitlab.manjaro.org/artwork/themes/breath/-/raw/master/colors/BreathDark.colors

# Change Color Scheme
kwriteconfig5 --file $USR_HOME/.config/kdeglobals \
              --group General \
              --key ColorScheme BreathDark


# Instant animation speed
kwriteconfig5 --file kdeglobals \
			  --group KDE \
			  --key AnimationDurationFactor 0
# Stop keyboard daemon from running on start
kwriteconfig5 --file kded5rc \
			  --group Module-keyboard \
			  --key autoload false
# Set low battery level to 15%
kwriteconfig5 --file powerdevilrc \
			  --group BatteryManagement \
			  --key BatteryLowLevel "15"
# Trigger quarter window tiling at 18%
kwriteconfig5 --file kwinrc \
			  --group Windows \
			  --key ElectricBorderCornerRatio "0.18"
# Define edge corner actions (display desktop grid)
kwriteconfig5 --file kwinrc \
			  --group "Effect-desktopgrid" \
			  --key BorderActivate "1"
# Define edge corner actions (display active desktop apps)
kwriteconfig5 --file kwinrc \
			  --group "Effect-windowview" \
			  --key BorderActivate "4"
# Corner action to launch application launcher
kwriteconfig5 --file kwinrc \
			  --group "ElectricBorders" \
			  --key BottomLeft "ApplicationLauncher"


# Move plasma scripts to the desktop update directory
cd $USR_HOME/Desktop/openSUSE-config/plasma-scripts/

mv ./A-taskbar-panel.js /usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/

mv ./B-configure-widgets.js /usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/


echo "	********* Script Completed *********	"
