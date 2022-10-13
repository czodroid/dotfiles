#!/bin/sh
#
# Filename: gnome-terminal-dconf.sh
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 11 September 2019
# Last Modified: Thursday 13 October 2022, 18:29
# $Id: gnome-terminal-dconf.sh,v 1.5 2022/10/13 16:34:20 czo Exp $
# Edit Time: 0:22:38
# Description:
#               dconf for gnome terminal
#
# Copyright: (C) 2019-2022 Olivier Sirol <czo@free.fr>

dconf load / << 'EOF'

#czo /* 2018/02/06 : Modified by Olivier Sirol <czo@free.fr> */
#dconf dump / > /root/dconf.1

[org/gnome/shell/extensions/system-monitor]
disk-display=true
cpu-system-color='#d3d7cfff'
center-display=false
disk-graph-width=30
memory-display=false
fan-sensor-file='/sys/class/hwmon/hwmon2/device/fan1_input'
show-tooltip=true
compact-display=false
disk-show-text=false
cpu-user-color='#eeeeecff'
net-show-text=false
disk-read-color='#eeeeecff'
disk-style='graph'
net-graph-width=30
memory-graph-width=30
icon-display=false
disk-usage-style='pie'
swap-graph-width=30
memory-show-text=false
thermal-display=false
move-clock=false
net-up-color='#babdb6ff'
battery-display=false
cpu-style='graph'
net-down-color='#eeeeecff'
cpu-nice-color='#00a3ffff'
cpu-graph-width=30
cpu-show-text=false
disk-write-color='#babdb6ff'

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
# font='Monospace Regular 13'
font='Source Code Pro for Powerline 13'
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


