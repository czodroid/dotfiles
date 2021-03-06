#!/bin/sh
#             ,,,
#            (o o)
####=====oOO--(_)--OOO==============================================####
#
# Filename: .profile
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: juil. 1995
# Last Modified: mercredi 12 mai 2021, 00:24
# Edit Time: 1:00:33
# Description:
#    ~/.profile: executed by the command interpreter for
#    login shells. This file is not read by bash(1), 
#    if ~/.bash_profile or ~/.bash_login exists.
#
# $Id: .profile,v 1.22 2021/05/12 08:54:49 czo Exp $

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# xmpp login alert
if [ -x "$HOME/xmpp-send-login42.pl" ]; then
( DATE=`date "+%Y-%m-%d %H:%M"` ; echo "LOGIN `id -un`@`hostname` at $DATE" ; who | grep "$DATE" ) | $HOME/xmpp-send-login42.pl > /dev/null 2>&1
fi

#export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1400x800

#if [ -x "/usr/bin/dbus-launch" ]; then
# export $(dbus-launch)
#fi

SHELLNAME=`echo $0 | sed 's,.*/,,' | sed 's,^-,,'`

# if running ash
if [ "$SHELLNAME" = "ash" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include /etc/bash.bashrc if it exists
    if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
    fi
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

