#             ,,,
#            (o o)
####=====oOO==(_)==OOo==============================================####
#
# Filename: .bashrc
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 23 November 1998
# Last Modified: Saturday 30 March 2024, 17:21
# $Id: .bashrc,v 1.598 2024/03/30 16:23:21 czo Exp $
# Edit Time: 137:57:06
# Description:
#
#       bash config file
#
#       This file is compatible with sh, ash, dash, mksh and bash.
#
#       bash and zsh have the same HISTFILE (~/.sh_history).
#       Just do a `ln -s ~/.sh_history ~/.bash_history'.
#       Because ~/.bashrc is executed by bash for non-login shells,
#       you need to create ~/.profile to include it. You must also
#       `rm ~/.bash_profile ~/.bash_login' which are not compatible
#       with ~/.profile.
#
# Copyright: (C) 1998-2024 Olivier Sirol <czo@free.fr>


##======= Debug ======================================================##

# set -v
# set -x
#RTMStart=$(date +%s%N)

##======= Interactive ================================================##

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

##======= Bash Settings ==============================================##

export TMPDIR=${TMPDIR-/tmp}
SHELLNAME=$( (echo $0 | sed 's,.*/,,' | sed 's,^-,,') 2>/dev/null )

if [ "X${SHELLNAME}" = "Xmksh" ]; then
    export HISTFILE=$HOME/.mksh_history
else
    export HISTFILE=$HOME/.sh_history
fi

if [ -n "$BASH_VERSION" ]; then
    export HISTFILESIZE=55000
    export HISTSIZE=44000
    export HISTCONTROL=ignorespace:erasedups

    # avoid overwriting history
    #shopt -s histappend
    shopt -u autocd
    shopt -s checkwinsize
    shopt -s dotglob
    shopt -s globstar
fi

export TIMEFORMAT=$'\n%3lR real    %3lU user    %3lS system    %P%%'

#BASHMISSING : REPORTTIME, complete alias, equal =foo
# removed zsh preexec implementation of REPORTTIME, see rev 1.32

if [ -n "$RTMStart" ] ; then echo -n "DEBUG BashSettings:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Platform ===================================================##

PLATFORM=Unknown

case $(uname 2>/dev/null) in

    Linux)
        case $(uname -m 2>/dev/null) in
            i*86)   PLATFORM=Linux_x86 ;;
            x86_64) PLATFORM=Linux ;;
            mips)   PLATFORM=Linux_mips ;;
            arm*)   PLATFORM=Linux_arm ;;
            aarch*) PLATFORM=Linux_aarch ;;
        esac
        ;;

    SunOS)
        case $(uname -r 2>/dev/null) in
            5*) PLATFORM=Solaris ;;
            *)  PLATFORM=SunOS ;;
        esac
        ;;

    CYGWIN*)
        PLATFORM=Cygwin ;;

    MINGW64*)
        PLATFORM=Mingw ;;

    # FreeBSD | OpenBSD | NetBSD | HP-UX | OSF1 | Darwin
    *)
        PLATFORM=$(uname 2>/dev/null)
        [ -z "$PLATFORM" ] && PLATFORM=Unknown
        ;;

esac

export PLATFORM

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Platform:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Paths ======================================================##

# Super big path pour Linux, FreeBSD, SunOS, Solaris

#FIXME: zsh typeset -U
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/etc/shell:$HOME/node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/pkg/bin:/usr/gnu/bin:/usr/local/ssh/bin:/usr/local/adm:/usr/local/etc:/usr/local/games:/usr/5bin:/usr/X11/bin:/usr/X11R5/bin:/usr/andrew/bin:/usr/bin/games:/usr/ccs/bin:/usr/dt/bin:/usr/etc:/usr/lang/bin:/usr/lib/teTeX/bin:/usr/libexec:/usr/mail/bin:/usr/oasys/bin:/usr/openwin/bin:/usr/sadm/bin:/usr/ucb:/usr/ucb/bin:/usr/share/bin:/usr/snadm/bin:/usr/vmsys/bin:/usr/xpg4/bin:/opt/bin:/usr/lib/gmt/bin:$PATH"

# $HOME/node_modules/.bin: needed for prettier, link in $HOME/.local/bin
# /usr/lib: needed 20 years ago...

## config cpanm perl libs not in distro
# export PERL_LOCAL_LIB_ROOT="$HOME/.local/perl";
# export PERL_MB_OPT="--install_base $HOME/.local/perl";
# export PERL_MM_OPT="INSTALL_BASE=$HOME/.local/perl";
# export PERL5LIB="$HOME/.local/perl/lib/perl5";
# export PATH="$HOME/.local/perl/bin:$PATH";

## config pip3 python libs not in distro
# # export PYTHONUSERBASE="$HOME/.local/python"
# python3 -m venv $HOME/.local/python
# export PATH="$HOME/.local/python/bin:$PATH"

## config android
if [ -d "$HOME/Android/android-studio/bin" ]; then
    # export PATH="$HOME/Android/Sdk/tools:$PATH"
    # export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
    # export PATH="$HOME/Android/Sdk/ndk-bundle:$PATH"
    export PATH="$HOME/Android/android-studio/bin:$PATH"
fi

## config openwrt
if [ -d /rom/bin ]; then
    export HISTFILE=$TMPDIR/.sh_history
    export PATH="$PATH:/rom/bin"
fi

## config termux for android
if [ -d /system/bin ]; then
    export TMPDIR=/data/data/com.termux/files/home/tmp
    export PATH="/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets:/system/bin:/system/xbin:/system/bin:/system/xbin:$PATH"
    export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
fi

## config SWARM
#export PATH="/users/project/swarm/data/tools/IpgpSoftwareTools:/users/project/swarm/data/tools/CommonSoftwareTools:$PATH"

# there was a time when I needed it, but I can't remember anymore...
#typeset -U MANPATH="$HOME/local/share/man:/usr/pkg/man:/usr/man:/usr/local/man:/usr/local/lib/gcc-lib/man:/usr/local/lib/perl5/man:/usr/local/lib/texmf/man:/usr/man/preformat:/usr/openwin/man:/usr/share/man:/usr/5bin/man:/usr/X11/man:/usr/X11R6/man:/usr/dt/man:/usr/lang/man:$MANPATH"
#export MANPATH

# export LD_RUN_PATH=/users/soft5/gnu/bazar/archi/Linux/lib/wxgtk/lib

export PATH

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Paths:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Environment Variables ======================================##

#if command -v most > /dev/null 2>&1; then
if [ -x "$(command -v hostname)" ]; then
    HOSTNAME=$(hostname 2>/dev/null)
else
    HOSTNAME=$(uname -n 2>/dev/null)
fi
export HOSTNAME=$(echo "$HOSTNAME" | sed 's/\..*//')

{ [ -x "$(command -v whoami)" ] && USER=$(whoami 2>/dev/null); } || USER=$(id -nu 2>/dev/null)
export USER

# GNU ls
export LS_COLORS='no=00:fi=00:di=94:ln=96:pi=30;104:so=37;45:do=30;105:bd=30;42:cd=30;102:or=31;107:su=37;41:sg=30;43:tw=37;44:ow=30;44:st=30;46:ex=97:*.7z=91:*.ace=91:*.arc=91:*.arj=91:*.bz2=91:*.bz=91:*.cab=91:*.cpio=91:*.deb=91:*.dz=91:*.ear=91:*.gz=91:*.jar=91:*.lha=91:*.lrz=91:*.lz4=91:*.lz=91:*.lzh=91:*.lzma=91:*.lzo=91:*.rar=91:*.rpm=91:*.rz=91:*.t7z=91:*.tar=91:*.taz=91:*.tbz2=91:*.tbz=91:*.tgz=91:*.tlz=91:*.txz=91:*.tz=91:*.tzst=91:*.war=91:*.xz=91:*.z=91:*.zip=91:*.zoo=91:*.zst=91:*.bmp=95:*.cgm=95:*.emf=95:*.flc=95:*.fli=95:*.gif=95:*.heic=95:*.heif=95:*.icns=95:*.ico=95:*.jpeg=95:*.jpg=95:*.mng=95:*.pbm=95:*.pcx=95:*.pgm=95:*.png=95:*.ppm=95:*.svg=95:*.svgz=95:*.tga=95:*.tif=95:*.tiff=95:*.webp=95:*.xbm=95:*.xcf=95:*.xpm=95:*.xwd=95:*.asf=35:*.avi=35:*.flv=35:*.m2v=35:*.m4v=35:*.mjpeg=35:*.mjpg=35:*.mkv=35:*.mov=35:*.mp4=35:*.mp4v=35:*.mpeg=35:*.mpg=35:*.nuv=35:*.ogm=35:*.ogv=35:*.ogx=35:*.qt=35:*.rm=35:*.rmvb=35:*.vob=35:*.webm=35:*.wmv=35:*.aac=36:*.au=36:*.flac=36:*.m4a=36:*.mid=36:*.midi=36:*.mka=36:*.mp3=36:*.mpc=36:*.oga=36:*.ogg=36:*.opus=36:*.ra=36:*.spx=36:*.wav=36:*.xspf=36:*.doc=92:*.docx=92:*.latex=92:*.man=92:*.md=92:*.odp=92:*.ods=92:*.odt=92:*.pdf=92:*.pod=92:*.ppt=92:*.pptx=92:*.tex=92:*.xls=92:*.xlsx=92:*.bat=93:*.c=93:*.c++=93:*.cc=93:*.cl=93:*.cmd=93:*.cpp=93:*.csh=93:*.css=93:*.cxx=93:*.el=93:*.f90=93:*.f=93:*.go=93:*.h=93:*.h++=93:*.hh=93:*.hpp=93:*.hs=93:*.htm=93:*.html=93:*.hxx=93:*.ino=93:*.java=93:*.js=93:*.json=93:*.l=93:*.less=93:*.lua=93:*.n=93:*.p=93:*.php=93:*.pl=93:*.pm=93:*.py=93:*.rb=93:*.rs=93:*.scss=93:*.sh=93:*.shtml=93:*.sql=93:*.sv=93:*.svh=93:*.v=93:*.vhd=93:*.vim=93:*.zsh=93'

# BSD ls
export LSCOLORS='ExGxfxFxHxacabxDxeae'

export LESS='-i -j5 -PLine\:%lb/%L (%pb\%) ?f%f:Standard input. [%i/%m] %B bytes'
export PAGER=less
export PERLDOC='-oterm'
export PERLDOC_PAGER='less -R'
export SYSTEMD_PAGER=cat
export APT_LISTCHANGES_FRONTEND=none

export RSYNC_RSH=ssh
export EDITOR=vim
export CVS_RSH=ssh
export CVSEDITOR=vim
export CVSIGNORE=.DS_Store

if [ "X${HOSTNAME}" != "Xbunnahabhain" ]; then
    export CVSROOT=czo@dalmore:/tank/data/czo/.cvsroot
else
    export CVSROOT=czo@dalmorechezwam:/tank/data/czo/.cvsroot
fi

case $(domainname 2>/dev/null) in
    NIS-CZO*) export PRINTER=U172-magos ;;
    *) export PRINTER=BW-Dressing ;;
esac

export PGPPATH="$HOME/.gnupg"
export HTML_TIDY="$HOME/.tidyrc"

if [ -n "$RTMStart" ] ; then echo -n "DEBUG EnvironmentVar:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Key bindings ===============================================##

if [ -n "$BASH_VERSION" ]; then

    #if [ -f ~/.inputrc ]; then
    #    bind -f ~/.inputrc
    #fi

    # Be 8 bit clean.
    bind 'set input-meta on'
    bind 'set output-meta on'
    bind 'set convert-meta off'

    # do not bell on tab-completion
    bind 'set bell-style none'
    #bind 'set bell-style visible'

    bind 'set show-all-if-ambiguous on'
    bind 'set show-all-if-unmodified on'
    bind 'set completion-query-items 1000'
    bind 'set page-completions off'
    bind 'set colored-stats on'
    bind 'set visible-stats on'
    #bind 'set history-preserve-point on'
    #bind 'set menu-complete-display-prefix on'

    # Czo defines pour mon mac et pc
    bind -x '"\C-xr": ". ~/.bashrc"'
    bind '"\C-xx": dump-functions'

    bind '"\e[C":     forward-char'
    bind '"\e[OC":    forward-char'
    bind '"\e[1;2C":  forward-char'
    bind '"\e[D":     backward-char'
    bind '"\e[OD":    backward-char'
    bind '"\e[1;2D":  backward-char'

    bind '"\e[H":     beginning-of-line'
    bind '"\e[OH":    beginning-of-line'
    bind '"\e[1~":    beginning-of-line'
    bind '"\e[7~":    beginning-of-line'
    bind '"\e[5;2~":  beginning-of-line'

    bind '"\e[F":     end-of-line'
    bind '"\e[OF":    end-of-line'
    bind '"\e[4~":    end-of-line'
    bind '"\e[8~":    end-of-line'
    bind '"\e[6;2~":  end-of-line'

    bind '"\e[1;5C":  shell-forward-word'
    bind '"\e[91~":   shell-forward-word'
    bind '"\eOc":     shell-forward-word'

    bind '"\e[1;5D":  shell-backward-word'
    bind '"\e[90~":   shell-backward-word'
    bind '"\eOd":     shell-backward-word'

    bind '"\e[A":     history-search-backward'
    bind '"\e[OA":    history-search-backward'
    bind '"\e[1;5A":  history-search-backward'

    bind '"\e[B":     history-search-forward'
    bind '"\e[OB":    history-search-forward'
    bind '"\e[1;5B":  history-search-forward'

    # bind '"\C-p":     previous-history'
    # bind '"\C-n":     next-history'
    bind '"\C-p":     history-search-backward'
    bind '"\C-n":     history-search-forward'

    bind '"\e[3~":    delete-char'
    bind '"\C-h":     backward-delete-char'

    bind '"\e[3;3~":  shell-kill-word'
    bind '"\M-h":     shell-backward-kill-word'

    bind '"\e\e":     kill-whole-line'
    bind '"\em":      "\C-w\C-y\C-y"'

    # doesnt work in readline
    #bind '"\C-z":     undo'
    # for US keybord : undo is ctrl-=
    # for FR keybord : undo is ctrl-shift-/
fi

if [ "X${SHELLNAME}" = "Xmksh" ]; then
    bind "^[[A"=search-history-up
    bind "^[[B"=search-history-down
fi

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Keybindings:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Completions ================================================##

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if [ -n "$BASH_VERSION" ]; then
    #linux
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
    #freebsd
    if [ -f /usr/local/share/bash-completion/bash_completion.sh ]; then
        . /usr/local/share/bash-completion/bash_completion.sh
    fi
fi

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Completions:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Aliases & Functions ========================================##

unalias -a

alias where='type -a'
alias t='type -a'
alias a='type -a'
alias eq='type -P'

alias st=". $HOME/.bashrc"
[ -f ~/.bashrc.czo ] && alias st=". $HOME/.bashrc.czo"
alias hi='fc -l -9111000'
alias h='fc -l -9111000 | sed "s/^[ \t]*[0-9]\+[ \t]\+//" | grep'

alias history_load='history -r'
alias history_save='history -w'
alias history_clear='history -c'
alias history_clear_all_log='echo > /var/log/wtmp ; echo > /var/log/lastlog ; history -c'
#BASHBUG history remove duplicates
alias history_bash_bug='history -n; history | tac | sed "s/^ *[0-9]\+ \+//" | sed "s/\s\+$//" | perl -ne  "print if not \$x{\$_}++;" | tac > $HISTFILE ; history -c ; history -r'

# csh compatibility env set
setenv() { export $1=$2; }
# v() { set | grep -ai $1; }

case $PLATFORM in

    Linux*)
        alias cp='\cp -i'
        alias mv='\mv -i'
        alias grep='\grep --color=auto'
        if \pgrep -fia 1 >/dev/null 2>&1; then
            alias pg='\pgrep -fia'
            alias pk='\pkill -fie'
        else
            alias pg='\pgrep -fl'
            alias pk='\pkill -f'
        fi
        if \lsblk -o NAME,SIZE,TYPE,PTTYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL >/dev/null 2>&1; then
            alias lsblk='\lsblk -o NAME,SIZE,TYPE,PTTYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL'
        elif \lsblk -o NAME,SIZE,TYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL >/dev/null 2>&1; then
            alias lsblk='\lsblk -o NAME,SIZE,TYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL'
        fi
        { \ps -eaf >/dev/null 2>&1 && alias ps='\ps -eaf'; } || alias ps='\ps -w'
        { \ls -l --time-style=long-iso >/dev/null 2>&1 && alias ls='LC_COLLATE=C \ls --time-style=long-iso --color=auto -a'; } || alias ls='LC_COLLATE=C \ls --color=auto -a'
        ;;

    FreeBSD)
        alias grep='\grep --color'
        alias ps='\ps -Awww'
        alias pg='\pgrep -fil'
        alias pk='\pkill -fil'
        { [ -x "$(command -v gnuls)" ] && alias ls='\gnuls --time-style=long-iso --color=auto -a'; } || alias ls='\ls -G -a'
        ;;

    NetBSD | OpenBSD)
        alias ps='\ps -Awww'
        { [ -x "$(command -v gnuls)" ] && alias ls='\gnuls --time-style=long-iso --color=auto -a'; } || alias ls='\ls -a'
        ;;

    Darwin)
        export DISPLAY=:0
        export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jbr/Contents/Home
        ## config macos brew
        export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:$PATH"
        alias grep='\grep --color'
        alias ps='\ps -Awww'
        alias pg='\pgrep -fil'
        alias pk='\pkill -fil'
        { [ -x "$(command -v gls)" ] && alias ls='\gls --time-style=long-iso --color=auto -a'; } || alias ls='\ls -G -a'
        ;;

    SunOS | Solaris)
        alias ps='\ps -ef'
        alias ls='\ls -a'
        alias pg='\pgrep -fl'
        alias pk='\pkill -fl'
        ;;

    Cygwin | Mingw)
        export DISPLAY=:0
        alias cp='\cp -i'
        alias mv='\mv -i'
        alias grep='\grep --color=auto'
        alias ps='\ps -aflW'
        alias pg='\pgrep -fia'
        alias pk='\pkill -fie'
        alias ls='\ls --time-style=long-iso --color=auto -a'
        ;;

esac

alias rule='echo "....|....1....|....2....|....3....|....4....|....5....|....6....|....7....|....8....|....9" '

#alias ls='\ls --time-style=long-iso --color=auto -a'
alias ll='ls -l'
alias lh='ls -lh'
alias l='ls -alrt'
alias g='grep -sri'
alias g_cs='grep -sr'
alias gl='\ls -1rt * | xargs grep -si --color=auto'
alias gl_cs='\ls -1rt * | xargs grep -s --color=auto'
alias ..='cd ..'

alias llt='find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -printf "%TF_%TR %5m %10s %p\n" | sort -n'
alias lls='find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -printf "%s %TF_%TR %5m %p\n" | sort -n'
alias llx='find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -perm -1 -print | sort'
alias lll='find . -type l  -printf "%p -> %l\n"'
alias md='\mkdir -p'
mdcd()    { \mkdir -p "$1" ; cd "$1"; }
ff() { find . -iname "*$1*"; }
ff_cs() { find . -name "*$1*"; }

alias rmf='rm -fr'
alias rmemptyf='find . -empty -type f -print -exec rm {} \;'
alias rmemptyd='find . -empty -type d -print -exec rm -fr {} \;'
alias rmbak='find . \( -iname "core" -o -iname "#*#" -o -iname "*.bak" -o -iname ".*.bak" -o -iname ".*.sw?" -o -iname "*~" -o -iname ".*~" -o -iname ".#*" -o -iname "._*" -o -iname ".DS_Store" -o -iname "Thumbs.db" -o -iname "Thumbs.db:encryptable" \) -type f -print -exec rm -f {} \;'

#command -v foo >/dev/null 2>&1
#[ -x "$(command -v foo)" ]
[ -x "$(command -v arp)" ] || arp() { cat /proc/net/arp; }
[ -x "$(command -v ldd)" ] || ldd() { LD_TRACE_LOADED_OBJECTS=1 $*; }
[ -x "$(command -v less)" ] || alias more=less

[ -f ~/.vimrc ] && export VIMINIT="source $HOME/.vimrc"
[ -f ~/.vimrc.czo ] && export VIMINIT="source $HOME/.vimrc.czo"
[ -x "$(command -v nvim)" ] && alias vim="\nvim"
[ -x "$(command -v vimx)" ] && alias vim="\vimx"
[ -x "$(command -v vim)"  ] && alias vim="\vim"

alias ne='\emacs -nw'

[ -f ~/.tmux.conf.czo ] && export MYTMUXRC="-f ~/.tmux.conf.czo"
alias tmux="\tmux $MYTMUXRC"
alias tmux0="tmux attach -t 0"
alias aa="tmux attach -d || tmux new"

# resets the terminal mouse when tmux crashes
alias r='tput rs2'

alias sc='screen -d -R'
alias mc='\mc -b -u'
#alias htop='\htop -C'
if [ -x "$(command -v ncdu)" ]; then
    \ncdu --color off -v >/dev/null 2>&1 && alias ncdu='\ncdu --color off'
fi

psg() { ps | grep -i $1 | sort -r -k 3 | grep -v "grep \!*\|sort -r -k 3"; }

n() { ncd $*; if [ $? -eq 0 ]; then cd "$(cat ~/.ncd_sdir)"; fi; }

alias wgetr='wget -m -np -k -r'
alias wgetp='wget -m -np -k -l1'

alias chmod644='chmod -R 755 . ; find . -type f -print0 | xargs -0 chmod 644'
alias chmodr='chmod -R a-st,u+rwX,g+rX-w,o+rX-w .'
alias chmodg='chmod -R a-st,u+rwX,g+rwX,o+rX-w .'

#alias tara='tar -czf'
tara() { V="${1%/*}" ; tar -czf "${V#*/}.tgz" "$1"; }
alias tarx='tar -xf'
alias tart='tar -tvf'
#alias tarxiso='cmake -E tar -xf'
#alias tarxiso='bsdtar -xf'
tarxiso() { V="${1%.*}" ; mkdir "$V" && bsdtar -C "$V" -xf "$1"; }

alias tsu='su - -c "cd /; /data/data/com.termux/files/usr/bin/bash --rcfile /data/data/com.termux/files/home/.bashrc"'

listext() { perl -e 'use File::Find (); File::Find::find(\&wanted, "."); sub wanted { if ((-f $_)) { $ext=$File::Find::name; $ext=~s,^.*\.,,; $list{$ext}++; } } foreach $key (sort {$list{$a} <=> $list{$b}} keys %list) { printf "$key : $list{$key}\n"; }'; }

alias ipl='curl czo.wf/ip'
alias ipf='curl czo.free.fr/ip'
alias ipa='ip a | grep "inet "'
alias ifa='ifconfig | grep "inet "'

alias lsusb_tree='lsusb -tv'

alias mount_list='P="mount | grep -v \" /sys\| /run\| /snap\| /proc\| /dev\""; echo "Runing: $P"; eval "$P"'
alias rsync_sys='echo "mount --bind / /mnt/rootfs ; then do rsync_full with/without -x..."'
alias rsync_full='rsync --numeric-ids -S -H --delete -av'
alias rsync_fat='rsync --no-p --no-g --modify-window=1 --delete -av -L'
alias rsync_normal='rsync --delete -av'

## My dotconfig files
# curl -k
# wget --no-check-certificate
# config:  https://git.io/JU6cm
# ssh:     https://git.io/JU6c2
# preseed: http://git.io/JkHdk
alias FF='curl -fsSL https://raw.githubusercontent.com/czodroid/dotfiles/master/config-fast-copy | sh'
alias FS='curl -fsSL https://raw.githubusercontent.com/czodroid/dotfiles/master/config-fast-ssh | sh'
alias FW='wget --no-check-certificate -qO- https://raw.githubusercontent.com/czodroid/dotfiles/master/config-debian-preseed | sh'

alias mail_test_root='(LC_ALL=C date ; printf "\nExcuse me, Mr. RoBot, I dont want to bother you. I always check\n/var/log/mail.log or journalctl -u postfix@-.service to identify\nany bugs.\n" ; printf "\n/etc/mailname:\n" ; cat /etc/mailname ; printf "\n/etc/aliases:\n" ; cat /etc/aliases ; printf "\n/etc/mail.rc:\n" ; cat /etc/mail.rc ; printf "\n$HOME/.forward:\n" ; cat $HOME/.forward ; printf "\n$HOME/.mailrc:\n" ; cat $HOME/.mailrc ; ) 2>&1 | mail -s "CZO, from $USER@$HOSTNAME, $(date +%Y-%m-%d\ %H:%M), do not reply" root'

alias passwd_md5='openssl passwd -1 '
alias passwd_sha512='openssl passwd -6 '
alias dig_lartha='curl -sk https://lartha/hosts.html'
alias ssha='eval $(ssh-agent); ssh-add; echo; echo "To add another identity:"; echo "ssh-add ~/.ssh/id_rsa_czo@bunnahabhain"'
ssh_tmux() { ssh -t $@ 'tmux attach -d || tmux new'; }
alias tmate_ssh='tmate -S ${TMPDIR}/tmate.sock new-session -d ; tmate -S ${TMPDIR}/tmate.sock wait tmate-ready ; tmate -S ${TMPDIR}/tmate.sock display -p "#{tmate_web}%n#{tmate_ssh}"'

tssh() { perl -e 'die "Usage: tssh host1 [hostN...]\n" unless ( @ARGV >= 1 ); foreach (@ARGV) { $N++; if ( $N == 1 ) { $CMD = "tmux new-window  ssh root\@$_ \\; \\\n"; } else { if ( ( $N - 1 ) % 4 == 0 ) { $FH = "-fh" } else { $FH = "   " } $CMD .= "split-window $FH ssh root\@$_ \\; \\\n"; } } $CMD .= "select-layout tiled \\; \\\n"; print "$CMD"; qx($CMD);' $@ ; }

# sed -i 173d ~/.ssh/known_hosts is working under linux,
# but on FreeBSD you must have gnu-sed, so perl is best!
sed_k() { perl -ni -e "print unless $. == $1 " ~/.ssh/known_hosts; }

# \xterm -geometry 90x26 -tn xterm-256color -bg "#282828" -fg "#c9b788" -fa "fixed:size=13"
# -xrm "XTerm*faceName:fixed:size=13"
# -xrm "XTerm*faceName:Source Code Pro For Powerline:size=13"
alias xterm='\xterm -xrm "XTerm*geometry:90x26" -xrm "XTerm*termName:xterm-256color" -xrm "XTerm*faceName:Source Code Pro For Powerline:size=13" -xrm "XTerm*allowBoldFonts:false" -xrm "XTerm*SimpleMenu*font:fixed" -xrm "XTerm*SimpleMenu*foreground:black" -xrm "XTerm*SimpleMenu*background:grey" -xrm "XTerm*scrollBar:false" -xrm "XTerm*saveLines:99000" -xrm "XTerm*visualBell:false" -xrm "XTerm*toolBar:false" -xrm "XTerm*allowTcapOps:false" -xrm "XTerm*eightBitInput:true" -xrm "XTerm*cursorBlink:on" -xrm "XTerm*cursorOnTime:600" -xrm "XTerm*cursorOffTime:600" -xrm "XTerm*allowSendEvents:false" -xrm "XTerm*sessionMgt:false" -xrm "XTerm*vt100.Translations:#override \n Shift Ctrl <KeyPress>V:insert-selection(PRIMARY, CUT_BUFFER0) \n Shift <KeyPress>Insert:insert-selection(PRIMARY, CUT_BUFFER0) \n Alt <KeyPress>v:insert-selection(PRIMARY, CUT_BUFFER0) \n" -xrm "XTerm*colorMode:on" -xrm "XTerm*dynamicColors:on" -xrm "XTerm*colorBDMode:on" -xrm "XTerm*colorBLMode:on" -xrm "XTerm*colorULMode:on" -xrm "XTerm*colorITMode:on" -xrm "XTerm*background:#282828" -xrm "XTerm*foreground:#c9b788" -xrm "XTerm*cursorColor:#98971a" -xrm "XTerm*color0:#282828" -xrm "XTerm*color8:#4a4239" -xrm "XTerm*color1:#cc241d" -xrm "XTerm*color9:#fb4934" -xrm "XTerm*color2:#98971a" -xrm "XTerm*color10:#b8bb26" -xrm "XTerm*color3:#fe8019" -xrm "XTerm*color11:#fabd2f" -xrm "XTerm*color4:#458588" -xrm "XTerm*color12:#83a598" -xrm "XTerm*color5:#b16286" -xrm "XTerm*color13:#d3869b" -xrm "XTerm*color6:#689d6a" -xrm "XTerm*color14:#8ec07c" -xrm "XTerm*color7:#c9b788" -xrm "XTerm*color15:#fbf1c7" -xrm "XTerm*colorBD:#fe8019" -xrm "XTerm*colorBL:#fabd2f" -xrm "XTerm*colorUL:#b16286" -xrm "XTerm*colorIT:#689d6a" -xrm "XTerm*highlightColorMode:true" -xrm "XTerm*highlightReverse:false" -xrm "XTerm*highlightColor:#458588" -xrm "XTerm*highlightTextColor:#fbf1c7"'

alias tree-cvs='tree -adn | grep -v CVS'
alias dft='df -hPT'

alias cvu='cd ~/etc ; cvs up ; cd -'
alias cvd='cd ~/etc ; cvs diff | colordiff ; cd -'
alias cvc='cd ~/etc ; cvs ci -mupdate ; cd -'
cvsdiff() { F=$1 ; cvs diff $(cvs log $F | grep "^revision" | sed -e "s/^revision/-r/" -e 1q) $F; }
cvsadddir() { find $1 -type d \! -name CVS -exec cvs add '{}' \; && find $1 \( -type d -name CVS -prune \) -o \( -type f -exec echo cvs add '{}' \; \); }

alias  gtu='git pull'
alias  gtp='git push'
alias  gtd='git diff'
alias  gtc='git commit -a'
alias gtcc='git commit -a -mupdate ; git push'
alias  gts='git status'
alias  gta='git add .'
alias  gtb='git branch -a'
alias  gtf='git fetch; git diff master origin/master'
alias gtgc='git gc'

#alias pkg_debian_list="apt-mark showmanual | LANG=C sort > pkg_list_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_debian_list="aptitude search '~i !~M' -F %p | sed 's/\s\+$//' | LANG=C sort > pkg_list_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_debian_list_long="dpkg-query -Wf '\${Package}\n' | LANG=C sort > pkg_list_long_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_debian_size="dpkg-query -Wf '\${Installed-Size} \${Package} (\${version})\n' | LANG=C sort -rn > pkg_size_${HOSTNAME}_$(date +%Y%m%d).txt"

alias pkg_redhat_list="dnf repoquery --userinstalled | LANG=C sort > pkg_list_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_redhat_list_long="rpm -qa --qf '%{NAME}\n' | LANG=C sort > pkg_list_long_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_redhat_size="rpm -qa --qf '%{SIZE} %{NAME} (%{VERSION})\n' | LANG=C sort -rn > pkg_size_${HOSTNAME}_$(date +%Y%m%d).txt"

alias pkg_arch_list="pacman -Qe | awk '{print \$1}' | LANG=C sort > pkg_list_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_arch_list_long="expac '%n' | LANG=C sort > pkg_list_long_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_arch_size="expac -H B '%m %n (%v)' | LANG=C sort -rn > pkg_size_${HOSTNAME}_$(date +%Y%m%d).txt"

# debian, ubuntu
alias AU='aptitude update && aptitude upgrade && aptitude clean && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'
alias AI='aptitude install'
alias AP='aptitude purge'
alias AS='aptitude search'
alias AW='aptitude show'
alias AUU='apt update && apt upgrade && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'
alias AII='apt-get install'
alias APP='apt-get remove --purge'
alias ASS='apt-cache search -n'
alias AWW='apt-cache show'
alias ALL='apt-file list'
alias AL='dpkg -L'
alias AF='dpkg -S'

# redhat, fedora
alias YU='yum update && yum clean all && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'
alias YI='yum install'
alias YP='yum remove'
YS() { yum list "*$1*"; }
alias YSS='yum search'
alias YW='rpm -qi'
alias YL='rpm -ql'
alias YF='rpm -qf'

# openwrt: opkg
alias OU='opkg update ; opkg list --size > /tmp/opkg.list && echo ; echo "opkg list is in /tmp/opkg.list"'
alias OI='opkg install'
alias OP='opkg remove'
OS() { grep $1 /tmp/opkg.list ;}
alias OW='opkg info'
alias OL='opkg files'
alias OF='opkg search'

# archlinux
alias PU='pacman --noconfirm -Sy archlinux-keyring && pacman --noconfirm -Su && { yes | pacman -Scc; } && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'
alias PI='pacman -Sy --needed'
alias PP='pacman -Rs'
alias PS='pacman -Ss'
alias PW='pacman -Qi'
alias PL='pacman -Ql'
alias PF='pacman -Qo'

# freebsd
alias KU='pkg update && pkg upgrade && pkg clean && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'

# brew macos
alias BU='brew update && brew upgrade && brew cleanup && sudo sh -c "echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate"'

# choco windows
alias CU='choco upgrade all -y && cyg-get.bat -upgrade all && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'

# suse: zypper
# netbsd: pkgin

alias sun='export TERM=sun-cmd ; echo TERM=$TERM'
alias vt100='export TERM=vt100 ; echo TERM=$TERM'
alias xte='export TERM=xterm ; echo TERM=$TERM'
alias xts='export TERM=screen ; echo TERM=$TERM'
alias xtc='export TERM=xterm-color ; echo TERM=$TERM'
alias xtc16='export TERM=xterm-16color ; echo TERM=$TERM'
alias xtc256='export TERM=xterm-256color ; echo TERM=$TERM'

alias console_color="printf '\e]P0282828\e]P1cc241d\e]P298971a\e]P3fe8019\e]P4458588\e]P5b16286\e]P6689d6a\e]P7c9b788\e]P84a4239\e]P9fb4934\e]PAb8bb26\e]PBfabd2f\e]PC83a598\e]PDd3869b\e]PE8ec07c\e]PFfbf1c7'; clear"
alias console_cursor_color="printf '\e]12;#98971a\a'"
alias console_cursor_blinking_block="printf '\e[0 q'"

alias 16color='for i in $(seq 0 7); do printf "\x1b[48;5;${i}m  "; done; printf "\x1b[0m\n"; for i in $(seq 8 15); do printf "\x1b[48;5;${i}m  "; done; printf "\x1b[0m\n";'

passwd_simple_encrypt() { perl -e 'print unpack("H*",  join("", map {$_^"*"} split(//,$ARGV[0])))."\n"' $1; }
passwd_simple_decrypt() { perl -e 'print join("",map{$_^"*"}split(//,pack("H*",$ARGV[0])))."\n"' $1; }

## -o pulse
sq() { SB=$( perl -mDigest::MD5=md5_hex -e 'print qq+squeezelite -n $ARGV[0] -m + . join(qq+:+, substr(md5_hex(qq+$ARGV[0]+),0,12) =~ /(..)/g)' $HOSTNAME ) ; echo $SB ; $SB & }

## OLD and RemeberThis_
alias RemeberThis_perl_sub='perl -i -pe "s/10\.9\./10.10./g" AAA*'
alias RemeberThis_sftp_vim='vim sftp://root@ananas//etc/munin/munin.conf'
alias RemeberThis_sftp_code='code --file-uri vscode-remote://ssh-remote+root@ananas/etc/munin/munin.conf'
alias RemeberThis_7z_passwd='7z a -mhe=on -ptruc bidule.7z bidule'
alias RemeberThis_GoPro_fps='ffmpeg -i in.mp4 -c:v libx264 -preset slow -crf 22 -c:a aac -strict experimental -pix_fmt yuv420p -r 29.97 out.mp4'
alias RemeberThis_GoPro_concat='ffmpeg -f concat -safe 0 -i <(for f in *0649*; do echo "file $PWD/$f"; done) -c copy output.mp4'
alias RemeberThis_iMovie_fps2997='export FPS=29.97 ; ffmpeg -f lavfi -i testsrc=duration=10:size=1920x1080:rate=$FPS -vf "drawtext=text=%{n}:fontsize=72:r=$FPS:x=(w-tw)/2: y=h-(2*lh):fontcolor=white:box=1:boxcolor=0x00000099" -pix_fmt yuv420p test-${FPS}fps.mp4'
alias RemeberThis_poweroff_FreeBSD5='shutdown -p +0'
alias RemeberThis_poweroff_macOS='shutdown -h now'
alias RemeberThis_zpool_create='zpool create -o ashift=12 -O compression=lz4 -O atime=on -O relatime=on tank1 /dev/XXX'
alias RemeberThis_zpool_create_crypted_passwd='zpool create -o ashift=12 -O compression=lz4 -O atime=on -O relatime=on -O encryption=on -O keyformat=passphrase -O keylocation=prompt -o feature@encryption=enabled tank1 /dev/XXX'
alias RemeberThis_zpool_create_crypted_file='dd if=/dev/urandom bs=32 count=1 of=/run/keyfile ; zpool create -o ashift=12 -O compression=lz4 -O atime=on -O relatime=on -O encryption=on -O keylocation=file:///run/keyfile -O keyformat=raw -o feature@encryption=enabled tank1 /dev/XXX'
alias RemeberThis_zpool_history='zpool history | grep -v "zfs destroy\|zfs snapshot\|zpool status\|zpool scrub\|zpool import\|zpool export\|zfs send\|zfs receive\|zfs rollback\|zfs rename\|zfs load-key"'
alias RemeberThis_zfs_destroy='for snapshot in $(zfs list -H -t snapshot | grep "auto_nightly_2023-10" | cut -f 1); do echo $snapshot ; zfs destroy -d $snapshot; done'
alias RemeberThis_zfs_rename='for snapshot in $(zfs list -H -t snapshot | grep "auto_nightly_" | grep -- "-90d" | cut -f 1); do echo $snapshot ; zfs rename $snapshot $(echo $snapshot | perl -pe "s/-90d/-60d/"); done'
alias RemeberThis_serial_connect='picocom -e z -b 115200 /dev/ttyUSB0'
alias RemeberThis_hdd_clear_unused_space_with_zeros='cat /dev/zero > /zero.dat; sync; rm /zero.dat'
alias RemeberThis_git_sort='git rev-list --objects --all | git cat-file --batch-check="%(objecttype) %(objectname) %(objectsize) %(rest)" | awk "/^blob/ {print substr(\$0,6)}" | sort --numeric-sort --key=2 | cut --complement --characters=13-40 | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=neares'
alias RemeberThis_ssh-keygen-passwd='ssh-keygen -p -f id_rsa'
alias RemeberThis_ssh-copy-id_openssh='cat ~/.ssh/id_rsa.pub | ssh root@debian10 "cat - >> .ssh/authorized_keys"'
alias RemeberThis_ssh-copy-id_owrt='cat ~/.ssh/id_rsa.pub | ssh root@sw-marion "cat - >> /etc/dropbear/authorized_keys"'
alias RemeberThis_list_path_binaries_bash='compgen -c | sort -u'
alias RemeberThis_list_path_binaries_zsh='print -rC1 -- ${(ko)commands}'
alias RemeberThis_chroot_mount="for p in proc sys dev dev/pts run ; do mount --make-rslave --rbind /\$p \$LIVE_BOOT/chroot/\$p ; done"
alias RemeberThis_chroot_umount="umount -lf \$LIVE_BOOT/chroot/{run,dev/pts,dev,sys,proc}"
alias RemeberThis_pkg_debian_purge_removed_pkg="dpkg --list | grep '^rc' | cut -d ' ' -f 3 | xargs dpkg --purge"
alias RemeberThis_pwd="find . -type d -exec sh -c \"cd '{}' && echo '######### {}' && pwd\" \;"
alias RemeberThis_kfm='setxkbmap fr mac'
alias RemeberThis_edl='export DISPLAY=localhost:0'
alias RemeberThis_remove_empty_line_and_slash_and_print="perl -n -e 'print unless m/^\s*#|^\s*$/'"
alias RemeberThis_export_svg2png='inkscape --export-width=128 --export-height=128 --export-png=icon.png icon.svg'
alias RemeberThis_slax_create_mksquashfs='mksquashfs . ../99-czo.sb -comp xz -Xbcj x86'
alias RemeberThis_macbook_kbd_bright_30='echo 30 > /sys/class/leds/smc\:\:kbd_backlight/brightness'
alias RemeberThis_macbook_vid_bright_30='echo 30 > /sys/class/backlight/acpi_video0/brightness'
alias RemeberThis_utf8_redode_this_directory="file -i * | grep iso-8859 | sed 's/:.*//' | xargs recode -t LATIN1..UTF-8"
alias RemeberThis_whatsappjpg='mogrify -resize 1918800@ -quality 75 *.jpg'
alias RemeberThis_favicon_png2ico='convert -background transparent favicon.png -define icon:auto-resize=16,24,32,48,64,72,96,128 favicon.ico'
alias RemeberThis_show_bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias RemeberThis_show_batcycle='cat /sys/class/power_supply/BAT0/cycle_count'
alias RemeberThis_mac_czo='openssl rand -hex 2 | sed "s/\(..\)\(..\)/00:67:90:79:\1:\2/"'
alias RemeberThis_mac_random='openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//"'
alias RemeberThis_kvm_pxe='kvm -m 1024 -device e1000,netdev=net0,mac=08:11:27:B8:F8:C8 -netdev tap,id=net0'
alias RemeberThis_proxmox_qma='qm create --memory 1024 --numa 0 --sockets 1 --cores 1 -ostype l26 --net0 virtio,bridge=vmbr0,firewall=1 --ide2 none,media=cdrom --scsihw virtio-scsi-pci --scsi0 local-vm:32,format=qcow2 --name test6000 6000'
RemeberThis_crossorigin_sri() { a=$(curl -s "$1" | openssl dgst -sha384 -binary | openssl enc -base64 -A) ; print "integrity=\"sha384-$a\" crossorigin=\"anonymous\""; }
RemeberThis_crossorigin_sri2() { a=$(shasum -b -a 384 "$1" | awk '{ print $1 }' | xxd -r -p | base64) ; print "integrity=\"sha384-$a\" crossorigin=\"anonymous\""; }

## GEOMAGNET
alias RemeberThis_bosedemerde='ssh root@localhost /home/czo/local/Linux/bin/usbresetv2 6 5'
alias RemeberThis_matlab='/users/soft/matlab/R2012A32x64/bin/matlab'
alias RemeberThis_matlab-console='/users/soft/matlab/R2012A32x64/bin/matlab -nodisplay -nodesktop -nosplash'
alias RemeberThis_ifort32='. /users/soft/intel/Compiler/11.1/059/bin/ifortvars.sh ia32'
alias RemeberThis_ifort64='. /users/soft/intel/Compiler/11.1/059/bin/ifortvars.sh intel64'
RemeberThis_ww() { uname -a; uptime; \ps --no-header -eo uid,user | sort -u | perl -ne 'BEGIN { $AutoReboot=0;$LoggedOnUsers=0;$RebootRequired=0;} @F=split (/\s+/) ; if ($F[1] > 1000 ) {$LoggedOnUsers++; print "$F[2] ($F[1])\n" } ; END { if ( -f "/var/run/reboot-required" ) { $RebootRequired=1 ;} ; print "RebootRequired=$RebootRequired\n" ; print "LoggedOnUsers=$LoggedOnUsers\n" ; if ( ! $LoggedOnUsers && $RebootRequired) {$AutoReboot=1;} print "AutoReboot=$AutoReboot\n" ; exit $AutoReboot }'; }

## CAO VLSI IBP.FR
alias RemeberThis_win='ssh-agent startx -- " -audit 4 -auth /users/cao/czo/.Xauthority"'
alias RemeberThis_xroot='xv -root +noresetroot -quit'
alias RemeberThis_xv='\xv -perfect -8'
alias RemeberThis_xload='\xload -hl red'
alias RemeberThis_key='perl -MCrypt::SKey -e key'
alias RemeberThis_vieux_acvs='export CVSROOT=/users/outil/alliance/cvsroot'
alias RemeberThis_imprime='a2ps -2 -s2'
alias RemeberThis_imprimeman='a2ps -2 -s2 -man'
alias RemeberThis_imprimescript='enscript --color -j --fancy-header=edd -E -r -2'
alias RemeberThis_xmbk='eval $(\xmbk -c 2>/dev/null)'
alias RemeberThis_mbk='set | grep "MBK\|RDS\|ELP" | sort'
alias RemeberThis_fing='finger | sort | uniq -w 15'

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Alias:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Main ======================================================##

# Terminal title
title() {
    case "$TERM" in
        xterm* | rxvt*)
            printf '\033]0;%s\007' "$*"
            ;;
        screen*)
            printf '\033k%s\033\\' "$*"
            printf '\033]0;%s\007' "$*"
            ;;
    esac
}

precmd() {
    title "${SHELLNAME} ${PWD} (${USER}@${HOSTNAME})"
}

# precmd Executed before each prompt.
PROMPT_COMMAND="precmd"
# run once for non bash shells
precmd

# like zsh preexec : it works in bash 5 !!!
if [ -n "$BASH_VERSION" ]; then
    # history 1 | sed "s/^\s*[0-9]\+\s\+//" # works in GNU, but doesnt on BSD
    # history 1 | awk "{sub(/^\s*[0-9]+\s+/,\"\") ; print}" # works in GNU, but doesnt on BSD
    # history 1 | perl -pe "s/^\s*[0-9]+\s+//" # maybe perl is not installed - but I love perl!
    # history 1 | awk "{sub(/^[ \t]*[0-9]+[ \t]+/,\"\") ; print}" # good on awk bsd and gnu!!!!!
    PS0='$(title "$(history 1 2>/dev/null | awk "{sub(/^[ \t]*[0-9]+[ \t]+/,\"\") ; print}" 2>/dev/null) (${USER}@${HOSTNAME})")'
fi

# busybox has no cksum on openWRT!
if [ -x "$(command -v cksum)" -a -x "$(command -v awk)" ]; then
    # hash for colors
    USER_PROMPT_COLOR=$( printf "AA$USER" | cksum | awk '{ print ((( $1  + 2 ) % 6 ) + 1 ) }' )
    HOST_PROMPT_COLOR=$( printf "JC$HOSTNAME" | cksum | awk '{ print ((( $1  + 1 ) % 6 ) + 1 ) }' )
else
    USER_PROMPT_COLOR="1"
    HOST_PROMPT_COLOR="5"
fi

# GIT
__git_ps1() { true ;}
# if [ -f /etc/bash_completion.d/git-prompt ]; then
#     export GIT_PS1_SHOWUPSTREAM=1       # (<, >, =)
#     export GIT_PS1_SHOWDIRTYSTATE=1     # (*)
#     export GIT_PS1_SHOWUNTRACKEDFILES=1 # (%)
#     export GIT_PS1_SHOWSTASHSTATE=1     # ($)
#     export GIT_PS1_DESCRIBE_STYLE=branch
#     . /etc/bash_completion.d/git-prompt
# fi
#
# parse_git_dirty() { [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"; }
# parse_git_branch() { git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"; }

if [ -x "$(command -v git)" ]; then
    __git_ps1() { git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/git:(\1)/"; }
fi

if [ -x "$(command -v tty)" ]; then
    MYTTY=$(tty 2>/dev/null | sed s,/dev/,,)
fi

if [ -n "$BASH_VERSION" ]; then
    PS1=$'\[\e[m\]\n\[\e[0;97m\][${PLATFORM}/${SHELLNAME}] - \D{.%Y%m%d_%Hh%M} - ${TERM}:${MYTTY}:sh${SHLVL} - \[\e[0;9$(E=$?; if [ $E -eq 0 ]; then echo 7; else echo 1; fi; exit $E 2>/dev/null)m\][$?]\[\e[m\]\n\[\e[0;9${USER_PROMPT_COLOR}m\]${USER}\[\e[0;97m\]@\[\e[0;9${HOST_PROMPT_COLOR}m\]${HOSTNAME}\[\e[0;97m\]:\[\e[0;96m\]$PWD\[\e[m\]\n\[\e[0;33m\]$(__git_ps1 "(%s)")\[\e[0;97m\]>>\[\e[m\] '
else
    # old sh/ash/dash/mksh .mkshrc .shrc .shinit ($' works in sh android but not in sh freebsd)
    PS1='[m
[0;97m[${PLATFORM}/${SHELLNAME}] - $(E=$?; date +.%Y%m%d_%Hh%M; exit $E) - ${TERM}:${MYTTY}:sh${SHLVL} - [0;9$(E=$?; if [ $E -eq 0 ]; then echo 7; else echo 1; fi; exit $E 2>/dev/null)m[$?][m
[0;9${USER_PROMPT_COLOR}m${USER}[0;97m@[0;9${HOST_PROMPT_COLOR}m${HOSTNAME}[0;97m:[0;96m$PWD[m
[0;33m$(__git_ps1 "(%s)")[0;97m>>[m '
fi


# limit -s
# ulimit unlimited

# Disable Ctrl-S / Ctrl-Q
[ -x "$(command -v stty)" ] && stty -ixon

umask 022

#FIXME: zsh, export -U PATH
if [ -x "$(command -v awk)" ]; then
    export PATH=$(echo "$PATH" | awk -F: '{for (i=1;i<=NF;i++) {if ( !x[$i]++ ) {if (ft++) printf(":"); printf("%s",$i); }}}')
fi

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Main:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

# EOF

