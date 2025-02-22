#             ,,,
#            (o o)
####=====oOO==(_)==OOo==============================================####
#
# Filename: .profile
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: juil. 1995
# Last Modified: Thursday 20 February 2025, 13:08
# $Id: .profile,v 1.52 2025/02/20 13:24:09 czo Exp $
# Edit Time: 3:05:58
# Description:
#
#       ~/.profile is included by the shell for login shells.
#
#       this file is not read by bash or zsh if these files exist:
#       > rm ~/.bash_profile ~/.bash_login ~/.zshenv ~/.zprofile ~/.zlogin
#
# Copyright: (C) 1995-2025 Olivier Sirol <czo@free.fr>

## umask
# umask 022

## xmpp login alert
if [ -x "$HOME/xmpp-send-login42.pl" ]; then
    sh -c '( DATE=`date "+%Y-%m-%d %H:%M"` ; echo "-> LOGIN `id -un`@`hostname` at $DATE" ; who | grep "$DATE" ; ) | $HOME/xmpp-send-login42.pl > /dev/null 2>&1 &'
fi

## include shell configuration
SHELLNAME=`{ echo $0 | sed 's,.*/,,' | sed 's,^-,,'; } 2>/dev/null`

# if running sh
case "$SHELLNAME" in
    sh | ash | dash | mksh)
        # include a *compatible* .bashrc if it exists. Start with -l
        if [ -f "$HOME/.bashrc" ]; then
            ENV="$HOME/.bashrc"
            export ENV
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

