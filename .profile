#             ,,,
#            (o o)
####=====oOO==(_)==OOo==============================================####
#
# Filename: .profile
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: juil. 1995
# Last Modified: Saturday 30 March 2024, 17:20
# $Id: .profile,v 1.46 2024/03/30 16:23:21 czo Exp $
# Edit Time: 2:16:23
# Description:
#
#       .profile config file
#
#       ~/.profile is included by the shell for login shells.
#       This file is not read by bash or zsh if ~/.bash_profile,
#       ~/.bash_login, ~/.zshenv, ~/.zprofile or ~/.zlogin exists.
#
# Copyright: (C) 1995-2024 Olivier Sirol <czo@free.fr>

## umask
# umask 022

## xmpp login alert
if [ -x "$HOME/xmpp-send-login42.pl" ]; then
    sh -c '( DATE=`date "+%Y-%m-%d %H:%M"` ; echo "-> LOGIN `id -un`@`hostname` at $DATE" ; who | grep "$DATE" ; ) | $HOME/xmpp-send-login42.pl > /dev/null 2>&1 &'
fi

## include shell configuration
# SHELLNAME=$(echo $0 | sed 's,.*/,,' | sed 's,^-,,')
SHELLNAME=$( (echo $0 | sed 's,.*/,,' | sed 's,^-,,') 2>/dev/null )


# if running sh
case "$SHELLNAME" in
    sh | ash | dash | mksh)
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

## remote desktop size
# export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1400x800

## dbus
# if [ -x "/usr/bin/dbus-launch" ]; then
#  export $(dbus-launch)
# fi

## startx
# [ ! $DISPLAY ] && [ ! $SSH_TTY ] && [ $XDG_VTNR == 1 ] && startx

## messages talk / write
mesg n 2> /dev/null || true

