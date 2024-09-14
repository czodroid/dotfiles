#!/bin/sh
#
# Filename: gnome-terminal-dconf.sh
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 11 September 2019
# Last Modified: Friday 13 September 2024, 18:41
# $Id: gnome-terminal-dconf.sh,v 1.11 2024/09/13 16:41:33 czo Exp $
# Edit Time: 0:34:00
# Description:
#               dconf for gnome terminal
#
# Copyright: (C) 2019-2024 Olivier Sirol <czo@free.fr>

dconf load / << 'EOF'


[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'


# dconf dump /org/gnome/shell/extensions/system-monitor/ > system-monitor.dconf
# dconf reset -f /org/gnome/shell/extensions/system-monitor

[org/gnome/shell/extensions/system-monitor]
background='#ffffff08'
cpu-graph-width=40
cpu-iowait-color='#e01b24ff'
cpu-nice-color='#26a269ff'
cpu-other-color='#613583ff'
cpu-show-text=false
cpu-system-color='#613583ff'
cpu-user-color='#26a269ff'
disk-display=true
disk-graph-width=40
disk-read-color='#26a269ff'
disk-show-text=false
disk-usage-style='bar'
disk-write-color='#c01c28ff'
icon-display=false
memory-display=false
net-collisions-color='#9141acff'
net-down-color='#26a269ff'
net-downerrors-color='#33d17aff'
net-graph-width=40
net-show-menu=true
net-show-text=false
net-up-color='#c01c28ff'
net-uperrors-color='#ed333bff'
show-tooltip=true

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

EOF


