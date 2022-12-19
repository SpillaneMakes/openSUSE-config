// Widget Functions
function forEachWidgetInContainmentList(containmentList, callback) {
    for (var containmentIndex = 0; containmentIndex < containmentList.length; containmentIndex++) {
        var containment = containmentList[containmentIndex];

        var widgets = containment.widgets();
        for (var widgetIndex = 0; widgetIndex < widgets.length; widgetIndex++) {
            var widget = widgets[widgetIndex];
            callback(widget, containment);
            if (widget.type === "org.kde.plasma.systemtray") {
                systemtrayId = widget.readConfig("SystrayContainmentId");
                if (systemtrayId) {
                    forEachWidgetInContainmentList([desktopById(systemtrayId)], callback)
                }
            }
        }
    }
}

function forEachWidget(callback) {
    forEachWidgetInContainmentList(desktops(), callback);
    forEachWidgetInContainmentList(panels(), callback);
}

function forEachWidgetByType(type, callback) {
    forEachWidget(function(widget, containment) {
        if (widget.type == type) {
            callback(widget, containment);
        }
    });
}

function logWidget(widget) {
    print("" + widget.type + ": ");

    var configGroups = widget.configGroups.slice(); // slice is used to clone the array
    for (var groupIndex = 0; groupIndex < configGroups.length; groupIndex++) {
        var configGroup = configGroups[groupIndex];
        print("\t" + configGroup + ": ");
        widget.currentConfigGroup = [configGroup];

        for (var keyIndex = 0; keyIndex < widget.configKeys.length; keyIndex++) {
            var configKey = widget.configKeys[keyIndex];
            var configValue = widget.readConfig(configKey);
            print("\t\t" + configKey + ": " + configValue);
        }
    }
}

function widgetSetProperty(args) {
    if (!(args.widgetType && args.configGroup && args.configKey)) {
        return;
    }

    forEachWidgetByType(args.widgetType, function(widget){
        widget.currentConfigGroup = [args.configGroup];

        //--- Delete when done debugging
        const oldValue = widget.readConfig(args.configKey);
        print("" + widget.type + " (id: " + widget.id + "):");
        print("\t[" + args.configGroup + "] " + args.configKey + ": " + oldValue + " => " + args.configValue + "\n");
        //--- End Debug

        widget.writeConfig(args.configKey, args.configValue);
    });
}


// Plasma Widget Changes
widgetSetProperty({ // Show battery percentage
    widgetType: "org.kde.plasma.battery",
    configGroup: "General",
    configKey: "showPercentage",
    configValue: "true",
});
widgetSetProperty({ // Iso date format
    widgetType: "org.kde.plasma.digitalclock",
    configGroup: "Appearance",
    configKey: "dateFormat",
    configValue: "isoDate",
});
widgetSetProperty({ // App menu tab icon
    widgetType: "org.kde.plasma.kickoff",
    configGroup: "General",
    configKey: "icon",
    configValue: "im-msn",
});
widgetSetProperty({ // Hide activity name from widget
    widgetType: "org.kde.plasma.showActivityManager",
    configGroup: "General",
    configKey: "showActivityName",
    configValue: "false",
});
widgetSetProperty({ // Pin frequently used apps
    widgetType: "org.kde.plasma.icontasks",
    configGroup: "General",
    configKey: "launchers",
    configValue: "applications:org.kde.konsole.desktop,applications:systemsettings.desktop,preferred://filemanager,file:///var/lib/flatpak/exports/share/applications/md.obsidian.Obsidian.desktop,preferred://browser,file:///var/lib/flatpak/exports/share/applications/com.spotify.Client.desktop,applications:com.bitwarden.desktop.desktop,file:///var/lib/flatpak/exports/share/applications/org.ferdium.Ferdium.desktop,applications:code.desktop",
});
