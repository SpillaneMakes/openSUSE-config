# Define home directory path from sudo user
USR_HOME="$(getent passwd $SUDO_USER | cut -d: -f6)"

# Include delete command in service menu
kwriteconfig5 --file $USR_HOME/.config/kdeglobals \
              --group KDE \
              --key ShowDeleteCommand true

# Remove unnecessary service menu actions
kwriteconfig5 --file $USR_HOME/.config/kservicemenurc \
              --group Show \
              --key slideshowfileitemaction false
kwriteconfig5 --file $USR_HOME/.config/kservicemenurc \
              --group Show \
              --key sharefileitemaction false

# Turn on double-click to open, single click to select
kwriteconfig5 --file $USR_HOME/.config/kdeglobals \
              --group KDE \
              --key SingleClick false

# Set scrollbar click to single click navigation
kwriteconfig5 --file $USR_HOME/.config/kdeglobals \
              --group Show \
              --key ScrollbarLeftClickNavigatesByPage false

# Make location/path bar editable
kwriteconfig5 --file $USR_HOME/.config/dolphinrc \
              --group General \
              --key EditableUrl true

# Show full path in titlebar
kwriteconfig5 --file $USR_HOME/.config/dolphinrc \
              --group General \
              --key ShowFullPath true

# Show path in window titlebar
kwriteconfig5 --file $USR_HOME/.config/dolphinrc \
              --group General \
              --key ShowFullPathInTitlebar true

# Allowing browsing through compressed archive files
kwriteconfig5 --file $USR_HOME/.config/dolphinrc \
              --group General \
              --key BrowseThroughArchives true

# Change dolphin toolbar style to icons only
kwriteconfig5 --file $USR_HOME/.config/dolphinrc \
              --group "Toolbar mainToolBar" \
              --key ToolButtonStyle IconOnly


# Delete unnecessary system folders
rm -d $USR_HOME/Videos
rm -d $USR_HOME/Templates
rm -d $USR_HOME/Music

# Insert custom dolphin toolbar
mkdir -p $USR_HOME/.local/share/kxmlgui5/dolphin/; mv ./ui-config/dolphinui.rc $_

# Update dolphin panel with new system folders
mv ./ui-config/user-places.xbel $USR_HOME/.local/share/

# Rename pictures folder
cd $USR_HOME
mv Pictures/ Media/

# Create new system folders
mkdir Dev/
mkdir CAD/
