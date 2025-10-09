#!/bin/sh
#
# Filename: gnome-terminal-dconf.sh
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 11 September 2019
# Last Modified: Thursday 09 October 2025, 19:46
# $Id: gnome-terminal-dconf.sh,v 1.18 2025/10/09 18:09:08 czo Exp $
# Edit Time: 0:57:32
# Description:
#
#        my dconf for gnome
#          - buttons
#          - terminal
#          - gnome-shell system-monitor
#          - gnome-shell dashtopanel
#          - gnome-shell arcmenu
#
#        add packages in debian 12:
#          AI gnome-shell-extension-system-monitor gnome-shell-extension-dash-to-panel gnome-shell-extension-arc-menu
#
# Copyright: (C) 2019-2025 Olivier Sirol <czo@free.fr>

dconf load / << 'EOF'


[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'


# dconf dump /org/gnome/terminal/ > gnometerm.dconf
# dconf reset -f /org/gnome/terminal/

[org/gnome/terminal/legacy]
default-show-menubar=false
menu-accelerator-enabled=false
schema-version=uint32 3
theme-variant='dark'

[org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9]
allow-bold=false
audible-bell=false
background-color='rgb(40,40,40)'
background-transparency-percent=6
bold-color='rgb(254,128,25)'
bold-color-same-as-fg=false
bold-is-bright=true
cursor-background-color='rgb(152,151,26)'
cursor-colors-set=true
cursor-foreground-color='rgb(40,40,40)'
cursor-shape='block'
default-size-columns=90
default-size-rows=24
font='Source Code Pro 13'
foreground-color='rgb(201,183,136)'
highlight-background-color='rgb(69,133,136)'
highlight-colors-set=true
highlight-foreground-color='rgb(251,241,199)'
palette=['rgb(40,40,40)', 'rgb(204,36,29)', 'rgb(152,151,26)', 'rgb(254,128,25)', 'rgb(69,133,136)', 'rgb(177,98,134)', 'rgb(104,157,106)', 'rgb(201,183,136)', 'rgb(74,66,57)', 'rgb(251,73,52)', 'rgb(184,187,38)', 'rgb(250,189,47)', 'rgb(131,165,152)', 'rgb(211,134,155)', 'rgb(142,192,124)', 'rgb(251,241,199)']
scrollback-unlimited=true
scrollbar-policy='never'
use-system-font=false
use-theme-background=false
use-theme-colors=false
use-theme-transparency=false
use-transparent-background=false
visible-name='gruvbox64'

# dconf dump /org/gnome/shell/extensions/system-monitor/ > system-monitor.dconf
# dconf reset -f /org/gnome/shell/extensions/system-monitor/

[org/gnome/shell/extensions/system-monitor]
background='#ffffff08'
battery-position=9
battery-show-menu=false
compact-display=false
cpu-graph-width=40
cpu-iowait-color='#e01b24ff'
cpu-nice-color='#26a269ff'
cpu-other-color='#613583ff'
cpu-position=0
cpu-show-text=false
cpu-system-color='#613583ff'
cpu-user-color='#26a269ff'
disk-display=true
disk-graph-width=40
disk-position=1
disk-read-color='#26a269ff'
disk-show-text=false
disk-usage-style='bar'
disk-write-color='#c01c28ff'
fan-position=8
fan-show-menu=false
freq-position=3
gpu-position=6
icon-display=false
memory-display=false
memory-position=4
net-collisions-color='#9141acff'
net-display=true
net-down-color='#26a269ff'
net-downerrors-color='#33d17aff'
net-graph-width=40
net-position=2
net-show-menu=true
net-show-text=false
net-speed-in-bits=false
net-up-color='#c01c28ff'
net-uperrors-color='#ed333bff'
show-tooltip=true
swap-position=5
thermal-position=7
tooltip-delay-ms=200

# dconf dump /org/gnome/shell/extensions/dash-to-panel/ > dashtopanel.dconf
# dconf reset -f /org/gnome/shell/extensions/dash-to-panel/

[org/gnome/shell/extensions/dash-to-panel]
animate-appicon-hover=false
animate-appicon-hover-animation-convexity={'RIPPLE': 2.0, 'PLANK': 1.0, 'SIMPLE': 0.0}
animate-appicon-hover-animation-duration={'SIMPLE': uint32 160, 'RIPPLE': 130, 'PLANK': 100}
animate-appicon-hover-animation-extent={'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}
animate-appicon-hover-animation-rotation={'SIMPLE': 0, 'RIPPLE': 10, 'PLANK': 0}
animate-appicon-hover-animation-travel={'SIMPLE': 0.29999999999999999, 'RIPPLE': 0.40000000000000002, 'PLANK': 0.0}
animate-appicon-hover-animation-type='SIMPLE'
animate-appicon-hover-animation-zoom={'SIMPLE': 1.0, 'RIPPLE': 1.25, 'PLANK': 2.0}
animate-show-apps=false
app-ctrl-hotkey-1=['<Control><Alt><Super>1']
app-ctrl-hotkey-10=['<Control><Alt><Super>0']
app-ctrl-hotkey-2=['<Control><Alt><Super>2']
app-ctrl-hotkey-3=['<Control><Alt><Super>3']
app-ctrl-hotkey-4=['<Control><Alt><Super>4']
app-ctrl-hotkey-5=['<Control><Alt><Super>5']
app-ctrl-hotkey-6=['<Control><Alt><Super>6']
app-ctrl-hotkey-7=['<Control><Alt><Super>7']
app-ctrl-hotkey-8=['<Control><Alt><Super>8']
app-ctrl-hotkey-9=['<Control><Alt><Super>9']
app-ctrl-hotkey-kp-1=['<Control><Alt><Super>KP_1']
app-ctrl-hotkey-kp-10=['<Control><Alt><Super>KP_0']
app-ctrl-hotkey-kp-2=['<Control><Alt><Super>KP_2']
app-ctrl-hotkey-kp-3=['<Control><Alt><Super>KP_3']
app-ctrl-hotkey-kp-4=['<Control><Alt><Super>KP_4']
app-ctrl-hotkey-kp-5=['<Control><Alt><Super>KP_5']
app-ctrl-hotkey-kp-6=['<Control><Alt><Super>KP_6']
app-ctrl-hotkey-kp-7=['<Control><Alt><Super>KP_7']
app-ctrl-hotkey-kp-8=['<Control><Alt><Super>KP_8']
app-ctrl-hotkey-kp-9=['<Control><Alt><Super>KP_9']
app-hotkey-1=['<Alt><Super>1']
app-hotkey-10=['<Alt><Super>0']
app-hotkey-2=['<Alt><Super>2']
app-hotkey-3=['<Alt><Super>3']
app-hotkey-4=['<Alt><Super>4']
app-hotkey-5=['<Alt><Super>5']
app-hotkey-6=['<Alt><Super>6']
app-hotkey-7=['<Alt><Super>7']
app-hotkey-8=['<Alt><Super>8']
app-hotkey-9=['<Alt><Super>9']
app-hotkey-kp-1=['<Alt><Super>KP_1']
app-hotkey-kp-10=['<Alt><Super>KP_0']
app-hotkey-kp-2=['<Alt><Super>KP_2']
app-hotkey-kp-3=['<Alt><Super>KP_3']
app-hotkey-kp-4=['<Alt><Super>KP_4']
app-hotkey-kp-5=['<Alt><Super>KP_5']
app-hotkey-kp-6=['<Alt><Super>KP_6']
app-hotkey-kp-7=['<Alt><Super>KP_7']
app-hotkey-kp-8=['<Alt><Super>KP_8']
app-hotkey-kp-9=['<Alt><Super>KP_9']
app-shift-hotkey-1=['<Shift><Alt><Super>1']
app-shift-hotkey-10=['<Shift><Alt><Super>0']
app-shift-hotkey-2=['<Shift><Alt><Super>2']
app-shift-hotkey-3=['<Shift><Alt><Super>3']
app-shift-hotkey-4=['<Shift><Alt><Super>4']
app-shift-hotkey-5=['<Shift><Alt><Super>5']
app-shift-hotkey-6=['<Shift><Alt><Super>6']
app-shift-hotkey-7=['<Shift><Alt><Super>7']
app-shift-hotkey-8=['<Shift><Alt><Super>8']
app-shift-hotkey-9=['<Shift><Alt><Super>9']
app-shift-hotkey-kp-1=['<Shift><Alt><Super>KP_1']
app-shift-hotkey-kp-10=['<Shift><Alt><Super>KP_0']
app-shift-hotkey-kp-2=['<Shift><Alt><Super>KP_2']
app-shift-hotkey-kp-3=['<Shift><Alt><Super>KP_3']
app-shift-hotkey-kp-4=['<Shift><Alt><Super>KP_4']
app-shift-hotkey-kp-5=['<Shift><Alt><Super>KP_5']
app-shift-hotkey-kp-6=['<Shift><Alt><Super>KP_6']
app-shift-hotkey-kp-7=['<Shift><Alt><Super>KP_7']
app-shift-hotkey-kp-8=['<Shift><Alt><Super>KP_8']
app-shift-hotkey-kp-9=['<Shift><Alt><Super>KP_9']
appicon-margin=5
appicon-padding=4
available-monitors=[0]
click-action='CYCLE'
dot-color-1='#c0bfbc'
dot-color-2='#c0bfbc'
dot-color-3='#c0bfbc'
dot-color-4='#c0bfbc'
dot-color-dominant=true
dot-color-override=false
dot-color-unfocused-1='#613583'
dot-color-unfocused-2='#613583'
dot-color-unfocused-3='#613583'
dot-color-unfocused-4='#613583'
dot-color-unfocused-different=false
dot-position='TOP'
dot-size=3
dot-style-focused='METRO'
focus-highlight=true
focus-highlight-color='#deddda'
focus-highlight-dominant=false
focus-highlight-opacity=25
group-apps=true
hide-overview-on-startup=true
hot-keys=false
hotkey-prefix-text='SuperAlt'
hotkeys-overlay-combo='TEMPORARILY'
intellihide=false
intellihide-animation-time=200
intellihide-behaviour='ALL_WINDOWS'
intellihide-close-delay=400
intellihide-enable-start-delay=2000
intellihide-hide-from-windows=false
intellihide-key-toggle=['<Super>i']
intellihide-key-toggle-text='<Super>i'
intellihide-only-secondary=false
intellihide-pressure-threshold=100
intellihide-pressure-time=1000
intellihide-show-in-fullscreen=false
intellihide-use-pressure=false
isolate-workspaces=false
leftbox-padding=-1
leftbox-size=0
middle-click-action='LAUNCH'
multi-monitors=true
overview-click-to-exit=true
panel-anchors='{"0":"MIDDLE"}'
panel-element-positions='{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"1":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'
panel-element-positions-monitors-sync=true
panel-lengths='{"0":100,"1":100}'
panel-positions='{"0":"TOP","1":"TOP"}'
panel-size=29
panel-sizes='{"0":32,"1":29}'
primary-monitor=0
scroll-panel-action='NOTHING'
shift-click-action='MINIMIZE'
shift-middle-click-action='LAUNCH'
shortcut=['<Super>q']
show-appmenu=false
show-apps-icon-file=''
show-apps-icon-side-padding=8
show-apps-override-escape=true
show-showdesktop-delay=1000
show-showdesktop-hover=false
show-showdesktop-time=300
showdesktop-button-width=8
status-icon-padding=-1
stockgs-force-hotcorner=false
stockgs-keep-dash=false
stockgs-keep-top-panel=false
stockgs-panelbtn-click-only=false
taskbar-locked=true
trans-bg-color='#1d2021'
trans-dynamic-anim-target=0.80000000000000004
trans-dynamic-anim-time=300
trans-dynamic-behavior='ALL_WINDOWS'
trans-dynamic-distance=20
trans-panel-opacity=0.75
trans-use-custom-bg=true
trans-use-custom-gradient=false
trans-use-custom-opacity=false
trans-use-dynamic-opacity=false
tray-padding=-1
tray-size=0
window-preview-hide-immediate-click=true
window-preview-title-position='TOP'

# dconf dump /org/gnome/shell/extensions/arcmenu/ > arcmenu.dconf
# dconf reset -f /org/gnome/shell/extensions/arcmenu/

[org/gnome/shell/extensions/arcmenu]
application-shortcuts-list=[['Settings', 'org.gnome.Settings', 'org.gnome.Settings.desktop'], ['Tweaks', 'org.gnome.tweaks-symbolic', 'org.gnome.tweaks.desktop'], ['Activities Overview', 'view-fullscreen-symbolic', 'ArcMenu_ActivitiesOverview'], ['Show All Applications', 'view-fullscreen-symbolic', 'ArcMenu_ShowAllApplications'], ['Terminal', 'utilities-terminal', 'org.gnome.Terminal.desktop'], ['Run Command...', 'system-run-symbolic', 'ArcMenu_RunCommand']]
arc-menu-icon=0
arc-menu-placement='DTP'
available-placement=[false, true, false]
border-color='rgb(63,62,64)'
custom-hot-corner-cmd='ArcMenu_ShowAllApplications'
custom-menu-button-icon='/usr/share/icons/Adwaita/scalable/places/start-here-symbolic.svg'
directory-shortcuts-list=[['Home', 'user-home-symbolic', 'ArcMenu_Home'], ['Desktop', '. GThemedIcon folder-documents-symbolic folder-symbolic folder-documents folder', '/tank/data/czo/Bureau'], ['Documents', '. GThemedIcon folder-documents-symbolic folder-symbolic folder-documents folder', 'ArcMenu_Documents'], ['Downloads', '. GThemedIcon folder-download-symbolic folder-symbolic folder-download folder', 'ArcMenu_Downloads'], ['Music', '. GThemedIcon folder-music-symbolic folder-symbolic folder-music folder', 'ArcMenu_Music'], ['Pictures', '. GThemedIcon folder-pictures-symbolic folder-symbolic folder-pictures folder', 'ArcMenu_Pictures'], ['Videos', '. GThemedIcon folder-videos-symbolic folder-symbolic folder-videos folder', 'ArcMenu_Videos']]
disable-recently-installed-apps=true
disable-tooltips=true
distro-icon=8
dtp-dtd-state=[true, false]
enable-custom-arc-menu=false
enable-large-icons=false
enable-menu-hotkey=false
enable-sub-menus=false
highlight-color='rgba(238, 238, 236, 0.1)'
highlight-foreground-color='rgba(255,255,255,1)'
hot-corners='Default'
left-panel-width=350
menu-arrow-size=0
menu-background-color='rgba(48,48,49,0.98)'
menu-border-color='rgb(60,60,60)'
menu-border-size=0
menu-button-appearance='Icon'
menu-button-icon='Custom_Icon'
menu-color='rgba(28, 28, 28, 0.98)'
menu-corner-radius=0
menu-font-size=9
menu-foreground-color='rgba(211, 218, 227, 1)'
menu-height=700
menu-item-active-bg-color='rgb(25,98,163)'
menu-item-active-fg-color='rgb(255,255,255)'
menu-item-hover-bg-color='rgb(21,83,158)'
menu-item-hover-fg-color='rgb(255,255,255)'
menu-margin=0
menu-separator-color='rgba(255,255,255,0.1)'
menu-width=272
multi-monitor=true
override-hot-corners=false
pinned-app-list=['Firefox Web Browser', '', 'firefox.desktop', 'Google Chrome', 'google-chrome', 'google-chrome.desktop', 'Microsoft Edge', '', 'microsoft-edge.desktop', 'Chromium Web Browser', '', 'chromium.desktop', 'Opera', '', 'opera.desktop', 'Terminal', '', 'org.gnome.Terminal.desktop', 'VTE term', '', 'vterm.desktop', 'Files', 'org.gnome.Nautilus', 'org.gnome.Nautilus.desktop', 'RealVNC Viewer', '', 'realvnc.desktop', 'Visual Studio Code', '', 'code.desktop', 'LibreOffice Writer', '', 'libreoffice-writer.desktop', 'Music', 'org.gnome.Music', 'org.gnome.Music.desktop', 'x48', '', 'x48.desktop', 'Characters', 'org.gnome.Characters', 'org.gnome.Characters.desktop', 'Extensions', 'org.gnome.Extensions', 'org.gnome.Extensions.desktop']
power-options=[(0, true), (1, true), (2, true), (3, true), (4, false), (5, false), (6, false)]
prefs-visible-page=0
recently-installed-apps=['rxvt-unicode.desktop', 'vteterm.desktop', 'gitkraken.desktop', 'nvim.desktop', 'opera.desktop', 'Zoom.desktop', 'chrome-ilmhmdfmddelebdbmckepncmelnjkmaa-Default.desktop', 'microsoft-edge-dev.desktop', 'discord.desktop', 'onboard-settings.desktop', 'onboard.desktop', 'Terminal.desktop', 'pdfsam.desktop', 'mutt.desktop', 'neomutt.desktop', 'virtualbox.desktop', 'vlc.desktop', 'chrome-ndllmijojpankpmfijjbnjehalehlgca-Default.desktop', 'x11vnc.desktop', 'org.kde.dolphin.desktop', 'org.kde.konsole.desktop', 'konqbrowser.desktop', 'org.kde.kwrite.desktop', 'org.kde.klipper.desktop', 'org.kde.kdeconnect.app.desktop', 'org.kde.kdeconnect.sms.desktop', 'org.kde.kdeconnect.kcm.desktop', 'org.kde.kdeconnect.nonplasma.desktop', 'org.kde.ksysguard.desktop', 'org.kde.kwalletmanager5.desktop', 'org.kde.discover.desktop', 'kdesystemsettings.desktop', 'debian-xterm.desktop', 'debian-uxterm.desktop', 'xfce4-terminal.desktop', 'nl.hjdskes.gcolor3.desktop', 'deepin-picker.desktop', 'gpick.desktop', 'org.kde.kcolorchooser.desktop', 'hardinfo.desktop', 'nextcloud.desktop', 'audacity.desktop', 'spek.desktop', 'xtigervncviewer.desktop', 'vivaldi-stable.desktop', 'chrome-efmjfjelnicpmdcmfikempdhlmainjcb-Default.desktop', 'filezilla.desktop', 'org.kde.kdeconnect.settings.desktop', 'deepin-calculator.desktop', 'dde-calendar.desktop', 'dde-control-center.desktop', 'dde-file-manager.desktop', 'deepin-album.desktop', 'deepin-devicemanager.desktop', 'deepin-font-manager.desktop', 'deepin-compressor.desktop', 'deepin-clone.desktop', 'deepin-editor.desktop', 'deepin-movie.desktop', 'deepin-screen-recorder.desktop', 'deepin-image-viewer.desktop', 'deepin-reader.desktop', 'deepin-system-monitor.desktop', 'deepin-terminal.desktop', 'mpv.desktop', 'laptop-mode-tools.desktop', 'deepin-music.desktop', 'deepin-boot-maker.desktop']
right-panel-width=250
search-entry-border-radius=(true, 25)
separator-color='rgb(63,62,64)'
vert-separator=false

EOF


