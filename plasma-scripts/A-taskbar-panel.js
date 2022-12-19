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
