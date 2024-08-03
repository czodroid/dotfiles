#!/bin/sh
#
# Filename: gnome-terminal-dconf.sh
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 11 September 2019
# Last Modified: Wednesday 10 July 2024, 13:27
# $Id: gnome-terminal-dconf.sh,v 1.8 2024/07/12 09:35:20 czo Exp $
# Edit Time: 0:24:36
# Description:
#               dconf for gnome terminal
#
# Copyright: (C) 2019-2024 Olivier Sirol <czo@free.fr>

dconf load / << 'EOF'

#czo /* 2018/02/06 : Modified by Olivier Sirol <czo@free.fr> */
#dconf dump / > /root/dconf.1

[org/gnome/shell/extensions/system-monitor]
battery-display=false
center-display=false
compact-display=false
cpu-display=true
cpu-graph-width=30
cpu-iowait-color='#c01c28ff'
cpu-nice-color='#ffffffff'
cpu-other-color='#813d9cff'
cpu-show-text=false
cpu-style='graph'
cpu-system-color='#9a9996ff'
cpu-user-color='#eeeeecff'
disk-display=true
disk-graph-width=30
disk-read-color='#eeeeecff'
disk-show-text=false
disk-style='graph'
disk-usage-style='pie'
disk-write-color='#813d9cff'
fan-sensor-file='/sys/class/hwmon/hwmon2/device/fan1_input'
icon-display=false
memory-display=false
memory-graph-width=30
memory-show-text=false
move-clock=false
net-collisions-color='#e66100ff'
net-down-color='#eeeeecff'
net-downerrors-color='#c01c28ff'
net-graph-width=30
net-show-text=false
net-up-color='#babdb6ff'
net-uperrors-color='#c01c28ff'
show-tooltip=true
swap-graph-width=30
thermal-display=false
tooltip-delay-ms=100


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


