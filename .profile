#             ,,,
#            (o o)
####=====oOO--(_)--OOO==============================================####
#
# Filename: .profile
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: juil. 1995
# Last Modified: Saturday 14 October 2023, 02:39
# $Id: .profile,v 1.35 2023/10/14 00:53:39 czo Exp $
# Edit Time: 1:27:37
# Description:
#    ~/.profile: executed by the command interpreter for login shells.
#    This file is not read by bash if ~/.bash_profile or ~/.bash_login
#    exists.
#
# Copyright: (C) 1995-2023 Olivier Sirol <czo@free.fr>

# The default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# xmpp login alert
if [ -x "$HOME/xmpp-send-login42.pl" ]; then
    sh -c '( DATE=`date "+%Y-%m-%d %H:%M"` ; echo "-> LOGIN `id -un`@`hostname` at $DATE" ; who | grep "$DATE" ; ) | $HOME/xmpp-send-login42.pl > /dev/null 2>&1 &'
fi

#export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1400x800

#if [ -x "/usr/bin/dbus-launch" ]; then
# export $(dbus-launch)
#fi

SHELLNAME=$(echo $0 | sed 's,.*/,,' | sed 's,^-,,')

# if running sh
case "$SHELLNAME" in
    sh | ash | dash)
        # include .bashrc if it exists
        if [ -f "$HOME/.bashrc" ]; then
            . "$HOME/.bashrc"
        fi
        ;;
esac

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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# startx
#[ ! $DISPLAY ] && [ ! $SSH_TTY ] && [ $XDG_VTNR == 1 ] && startx

# mesg n 2> /dev/null || true

