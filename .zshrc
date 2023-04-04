#             ,,,
#            (o o)
####=====oOO--(_)--OOO==============================================####
#
# Filename: .zshrc
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 23 April 1996
# Last Modified: Tuesday 04 April 2023, 19:00
# $Id: .zshrc,v 1.474 2023/04/04 17:08:11 czo Exp $
# Edit Time: 136:01:48
# Description:
#         ~/.zshrc is sourced in interactive shells.
#         rm ~/.zshenv ~/.zprofile ~/.zlogin ~/.zsh_history
#         and put instead .profile
#         This is Alex Fenyo, my guru, who made me discover this
#         amazing shell in 1996... I am forever grateful to him.
#
# Copyright: (C) 1996-2023 Olivier Sirol <czo@free.fr>

##======= Debug ======================================================##

# zmodload zsh/zprof
# set -v
# set -x
#RTMStart=$(date +%s%N)

##======= Zsh Settings ===============================================##

setopt ALWAYS_TO_END          # On completion go to end of word
setopt NO_AUTO_CD             # Directory as command does cd
setopt AUTO_PUSHD             # cd uses directory stack too
setopt NO_BG_NICE             # (!*)Background jobs at lower priority
setopt CD_SILENT              # Never print the working directory (new zsh version...)
setopt NO_CHECK_JOBS          # (!*)Check jobs before exiting shell
setopt COMBINING_CHARS        # Displays combining characters correctly
#setopt COMPLETE_IN_WORD       # Completion works inside words (doesnt work: scp root@myhost-M:/foo)
setopt NO_EXTENDED_GLOB       # See globbing section above
setopt GLOB_COMPLETE          # Patterns are active in completion
setopt NO_GLOB_DOTS           # Patterns may match leading dots
setopt HIST_IGNORE_ALL_DUPS   # Remove all earlier duplicate lines
setopt HIST_REDUCE_BLANKS     # Trim multiple insgnificant blanks
setopt HIST_SAVE_NO_DUPS      # Remove duplicates when saving
setopt NO_HUP                 # (!*)Send SIGHUP to proceses on exit
setopt INTERACTIVE_COMMENTS   # Dash on interactive line for comment
setopt INTERACTIVE            # Shell is interactive
setopt LONG_LIST_JOBS         # More verbose listing of jobs
setopt MONITOR                # Shell has job control enabled
setopt PROMPT_SUBST           # $ expansion etc. in prompts
setopt PUSHD_IGNORE_DUPS      # Don’t push dir multiply on stack
setopt PUSHD_MINUS            # Reverse sense of – and + in pushd
setopt RM_STAR_SILENT         # Don’t warn on rm *
setopt SH_WORD_SPLIT          # Split non­array variables yuckily

export TMPDIR=${TMPDIR-/tmp}

export HISTFILE=$HOME/.sh_history
export SAVEHIST=55000
export HISTSIZE=44000
# screen size
#export LISTMAX=0
export LISTMAX=1000

export REPORTTIME=5

DIRSTACKSIZE=20
watch=(notme)
WATCHFMT='%n %a %l from %m at %t.'
# check every 5 min for login/logout activity
#LOGCHECK=300
#MAILCHECK=300
# Filename suffixes to ignore during completion
#fignore=(.o .c~ .old .pro)
# Search path for the cd command
#cdpath=(.. ~ ~/src ~/zsh)

export TIMEFMT=$'\n%*E real    %*U user    %*S system    %P'

if [ -n "$RTMStart" ] ; then echo -n "DEBUG ZshSettings:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

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
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/etc/shell:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/pkg/bin:/usr/gnu/bin:/usr/local/ssh/bin:/usr/local/adm:/usr/local/etc:/usr/local/games:/usr/5bin:/usr/X11/bin:/usr/X11R5/bin:/usr/andrew/bin:/usr/bin/games:/usr/ccs/bin:/usr/dt/bin:/usr/etc:/usr/lang/bin:/usr/lib/teTeX/bin:/usr/libexec:/usr/mail/bin:/usr/oasys/bin:/usr/openwin/bin:/usr/sadm/bin:/usr/ucb:/usr/ucb/bin:/usr/share/bin:/usr/snadm/bin:/usr/vmsys/bin:/usr/xpg4/bin:/opt/bin:/usr/lib/gmt/bin:$PATH"

# /usr/lib:

## config cpanm perl libs not in distro
#export PERL_LOCAL_LIB_ROOT="$HOME/.local/perl";
#export PERL_MB_OPT="--install_base $HOME/.local/perl";
#export PERL_MM_OPT="INSTALL_BASE=$HOME/.local/perl";
#export PERL5LIB="$HOME/.local/perl/lib/perl5";
#export PATH="$HOME/.local/perl/bin:$PATH";

## config pip3 python libs not in distro
#export PYTHONUSERBASE="$HOME/.local/python"
#export PATH="$HOME/.local/python/bin:$PATH";

## config android
if [ -d "$HOME/Android/android-studio/bin" ]; then
    # export PATH="$HOME/Android/Sdk/tools:$PATH"
    # export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
    # export PATH="$HOME/Android/Sdk/ndk-bundle:$PATH"
    export PATH="$HOME/Android/android-studio/bin:$PATH"
fi

## config openwrt
if [ -d /rom/bin ]; then
    export PATH="$PATH:/rom/bin"
fi

## config termux for android
if [ -d /system/bin ]; then
    export TMPDIR=/data/local/tmp
    export PATH="/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets:/system/bin:/system/xbin:/system/bin:/system/xbin:$PATH"
    export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
fi

## config SWARM
#export PATH="/users/project/swarm/data/tools/IpgpSoftwareTools:/users/project/swarm/data/tools/CommonSoftwareTools:$PATH"

# there was a time when I needed it, but I can't remember anymore...
#typeset -U MANPATH="$HOME/local/share/man:/usr/pkg/man:/usr/man:/usr/local/man:/usr/local/lib/gcc-lib/man:/usr/local/lib/perl5/man:/usr/local/lib/texmf/man:/usr/man/preformat:/usr/openwin/man:/usr/share/man:/usr/5bin/man:/usr/X11/man:/usr/X11R6/man:/usr/dt/man:/usr/lang/man:$MANPATH"
#export MANPATH

# export LD_RUN_PATH=/users/soft5/gnu/bazar/archi/Linux/lib/wxgtk/lib

export -U PATH

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Paths:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Environment Variables ======================================##

if [ -x "$(command -v getprop)" ]; then
    HOSTNAME=$(getprop net.hostname android 2>/dev/null)
elif [ -x "$(command -v hostname)" ]; then
    HOSTNAME=$(hostname 2>/dev/null)
else
    HOSTNAME=$(uname -n 2>/dev/null)
fi
export HOSTNAME=$(echo "$HOSTNAME" | sed 's/\..*//')

{ [ -x "$(command -v whoami)" ] && USER=$(whoami 2>/dev/null); } || USER=$(id -nu 2>/dev/null)
export USER

# GNU ls
export LS_COLORS='no=00:fi=00:di=94:ln=96:pi=30;104:so=37;45:do=30;105:bd=30;42:cd=30;102:or=31;107:su=37;41:sg=30;43:tw=37;44:ow=30;44:st=30;46:ex=97:*.7z=91:*.ace=91:*.arc=91:*.arj=91:*.bz2=91:*.bz=91:*.cab=91:*.cpio=91:*.deb=91:*.dz=91:*.ear=91:*.gz=91:*.jar=91:*.lha=91:*.lrz=91:*.lz4=91:*.lz=91:*.lzh=91:*.lzma=91:*.lzo=91:*.rar=91:*.rpm=91:*.rz=91:*.t7z=91:*.tar=91:*.taz=91:*.tbz2=91:*.tbz=91:*.tgz=91:*.tlz=91:*.txz=91:*.tz=91:*.tzst=91:*.war=91:*.xz=91:*.z=91:*.Z=91:*.zip=91:*.zoo=91:*.zst=91:*.bmp=95:*.cgm=95:*.emf=95:*.flc=95:*.fli=95:*.gif=95:*.icns=95:*.ico=95:*.jpeg=95:*.jpg=95:*.mng=95:*.pbm=95:*.pcx=95:*.pgm=95:*.png=95:*.ppm=95:*.svg=95:*.svgz=95:*.tga=95:*.tif=95:*.tiff=95:*.webp=95:*.xbm=95:*.xcf=95:*.xpm=95:*.xwd=95:*.asf=35:*.avi=35:*.flv=35:*.m2v=35:*.m4v=35:*.mjpeg=35:*.mjpg=35:*.mkv=35:*.mov=35:*.mp4=35:*.mp4v=35:*.mpeg=35:*.mpg=35:*.nuv=35:*.ogm=35:*.ogv=35:*.ogx=35:*.qt=35:*.rm=35:*.rmvb=35:*.vob=35:*.webm=35:*.wmv=35:*.aac=36:*.au=36:*.flac=36:*.m4a=36:*.mid=36:*.midi=36:*.mka=36:*.mp3=36:*.mpc=36:*.oga=36:*.ogg=36:*.opus=36:*.ra=36:*.spx=36:*.wav=36:*.xspf=36:*.css=92:*.csv=92:*.doc=92:*.docx=92:*.htm=92:*.html=92:*.json=92:*.latex=92:*.less=92:*.log=92:*.mak=92:*.man=92:*.md=92:*.odp=92:*.ods=92:*.odt=92:*.pdf=92:*.pod=92:*.ppt=92:*.pptx=92:*.sass=92:*.scss=92:*.shtml=92:*.tex=92:*.txt=92:*.xls=92:*.xlsx=92:*.xml=92:*.bat=93:*.c=93:*.C=93:*.cc=93:*.cl=93:*.cmd=93:*.cpp=93:*.csh=93:*.cxx=93:*.el=93:*.f90=93:*.f=93:*.F=93:*.go=93:*.h=93:*.hh=93:*.hpp=93:*.hs=93:*.ino=93:*.java=93:*.js=93:*.l=93:*.lua=93:*.n=93:*.p=93:*.php=93:*.pl=93:*.pm=93:*.py=93:*.rb=93:*.rs=93:*.sh=93:*.sql=93:*.sv=93:*.svh=93:*.v=93:*.vhd=93:*.vim=93:*.zsh=93:'

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

##======= Autoload functions =========================================##

# Where to look for autoloaded function definitions
#typeset -U FPATH=$FPATH:$HOME/etc/zsh/functions
#export FPATH

# copy autoload -U history-search-end

czo-history-search-end() {
#
# This implements functions like history-beginning-search-{back,for}ward,
# but takes the cursor to the end of the line after moving in the
# history, like history-search-{back,for}ward.  To use them:
#   zle -N history-beginning-search-backward-end history-search-end
#   zle -N history-beginning-search-forward-end history-search-end
#   bindkey '...' history-beginning-search-backward-end
#   bindkey '...' history-beginning-search-forward-end

integer cursor=$CURSOR mark=$MARK

if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
  # Last widget called set $MARK.
  CURSOR=$MARK
else
  MARK=$CURSOR
fi

if zle .${WIDGET%-end}; then
  # success, go to end of line
  zle .end-of-line
else
  # failure, restore position
  CURSOR=$cursor
  MARK=$mark
  return 1
fi
}

zle -N history-beginning-search-backward-end czo-history-search-end
zle -N history-beginning-search-forward-end czo-history-search-end

# Autoload all shell functions from all directories
# in $fpath that have the executable bit on
# (the executable bit is not necessary, but gives
# you an easy way to stop the autoloading of a
# particular shell function).
#for dirname in $fpath
#do
#  autoload $dirname/*(.x:t)
#done

##======= Key bindings ===============================================##

# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Z' accept-and-hold

# emacs key bindings
bindkey -e

# Czo defines
bindkey -s "\C-xr"  "^Qsource ~/.zshrc^M"
bindkey -s "\C-xx"  "^Qbindkey^M"

bindkey "\e[Z"     reverse-menu-complete

bindkey "\e[C"     forward-char
bindkey "\e[OC"    forward-char
bindkey "\e[1;2C"  forward-char
bindkey "\e[D"     backward-char
bindkey "\e[OD"    backward-char
bindkey "\e[1;2D"  backward-char

bindkey "\e[H"     beginning-of-line
bindkey "\e[OH"    beginning-of-line
bindkey "\e[1~"    beginning-of-line
bindkey "\e[7~"    beginning-of-line
bindkey "\e[5;2~"  beginning-of-line

bindkey "\e[F"     end-of-line
bindkey "\e[OF"    end-of-line
bindkey "\e[4~"    end-of-line
bindkey "\e[8~"    end-of-line
bindkey "\e[6;2~"  end-of-line

bindkey "\e[1;5C"  forward-word
bindkey "\e[91~"   forward-word
bindkey "\eOc"     forward-word

bindkey "\e[1;5D"  backward-word
bindkey "\e[90~"   backward-word
bindkey "\eOd"     backward-word

bindkey "\e[A"     history-beginning-search-backward
bindkey "\eOA"     history-beginning-search-backward
bindkey "\e[1;5A"  history-beginning-search-backward

bindkey "\e[B"     history-beginning-search-forward
bindkey "\eOB"     history-beginning-search-forward
bindkey "\e[1;5B"  history-beginning-search-forward

#bindkey "\C-p"     up-line-or-history
#bindkey "\C-n"     down-line-or-history
bindkey "\C-p"     history-beginning-search-backward
bindkey "\C-n"     history-beginning-search-forward

bindkey "\e[3~"    delete-char
bindkey "\C-h"     backward-delete-char

bindkey "\e[3;3~"  delete-word
bindkey "\M-h"     backward-delete-word

bindkey "\e\e"     kill-buffer
bindkey "\em"      copy-prev-shell-word


# copied from Zsh zle shift selection
# https://stackoverflow.com/questions/5407916/zsh-zle-shift-selection/12193631

r-delregion() {
  if ((REGION_ACTIVE)); then
    zle kill-region
  else
    local widget_name=$1
    shift
    zle $widget_name -- $@
  fi
}

r-deselect() {
  ((REGION_ACTIVE = 0))
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

r-select() {
  ((REGION_ACTIVE)) || zle set-mark-command
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

for key     kcap   seq        mode   widget (
    sleft   kLFT   $'\e[1;2D' select   backward-char
    sright  kRIT   $'\e[1;2C' select   forward-char
    sup     kri    $'\e[1;2A' select   history-beginning-search-backward
    sdown   kind   $'\e[1;2B' select   history-beginning-search-forward

    send    kEND   $'\E[1;2F' select   end-of-line
    send2   x      $'\E[4;2~' select   end-of-line

    shome   kHOM   $'\E[1;2H' select   beginning-of-line
    shome2  x      $'\E[1;2~' select   beginning-of-line

    left    kcub1  $'\EOD'    deselect backward-char
    right   kcuf1  $'\EOC'    deselect forward-char

    end     kend   $'\EOF'    deselect end-of-line
    end2    x      $'\E4~'    deselect end-of-line

    home    khome  $'\EOH'    deselect beginning-of-line
    home2   x      $'\E1~'    deselect beginning-of-line

    csleft  x      $'\E[1;6D' select   backward-word
    csright x      $'\E[1;6C' select   forward-word
    csend   x      $'\E[1;6F' select   end-of-line
    cshome  x      $'\E[1;6H' select   beginning-of-line

    cleft   x      $'\E[1;5D' deselect backward-word
    cright  x      $'\E[1;5C' deselect forward-word

    del     kdch1   $'\E[3~'  delregion delete-char
    bs      x       $'^?'     delregion backward-delete-char

  ) {
  eval "key-$key() {
    r-$mode $widget \$@
  }"
  zle -N key-$key
  bindkey "${terminfo[$kcap]-$seq}" key-$key
}

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Keybindings:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Completions ================================================##

autoload -Uz compinit
compinit
#compinit -d ${HOME}/.zcompdump-${HOSTNAME}-${ZSH_VERSION}
#compinit -C

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompcache
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# messages/warnings format
zstyle ':completion:*:descriptions' format $' %{\e[0;92m%}-- %d --%{\e[m%}'
zstyle ':completion:*:messages'     format $' %{\e[0;93m%}-- %d --%{\e[m%}'
zstyle ':completion:*:corrections'  format $' %{\e[0;91m%}-- %d (errors: %e) --%{\e[m%}'
zstyle ':completion:*:warnings'     format $' %{\e[0;91m%}-- no matches for: %d --%{\e[m%}'

if [ -n "$RTMStart" ] ; then echo -n "DEBUG Completions:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

##======= Aliases & Functions ========================================##

unalias -m '*'


#alias where='whence -ca'
alias t='whence -ca'
alias a='whence -ca'
alias eq='whence -p'

alias st='source ~/.zshrc'
alias hi='fc -l 1'
alias h='fc -l 1 | grep'

alias history_load='fc -R'
alias history_save='fc -AI'
alias history_clear='local HISTSIZE=0'
alias history_clear_all_log='echo > /var/log/wtmp ; echo > /var/log/lastlog ; local HISTSIZE=0'

alias .='source'

# csh compatibility env set
setenv() { export $1=$2; }
# v() { set | grep -ai $1; }

case $PLATFORM in

    Linux*)
        alias cp='\cp -i'
        alias mv='\mv -i'
        alias grep='\grep --color'
        if \pgrep -fia 1 >/dev/null 2>&1; then
            alias pg='\pgrep -fia'
            alias pk='\pkill -fie'
        else
            alias pg='\pgrep -fl'
            alias pk='\pkill -fl'
        fi
        if \lsblk -o NAME,SIZE,TYPE,PTTYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL >/dev/null 2>&1; then
            alias lsblk='\lsblk -o NAME,SIZE,TYPE,PTTYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL'
        elif \lsblk -o NAME,SIZE,TYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL >/dev/null 2>&1; then
            alias lsblk='\lsblk -o NAME,SIZE,TYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL'
        fi
        { \ps -eaf >/dev/null 2>&1 && alias ps='\ps -eaf'; } || alias ps='\ps -w'
        { \ls -l --time-style=long-iso >/dev/null 2>&1 && alias ls='\ls --time-style=long-iso --color=auto -a'; } || alias ls='\ls --color=auto -a'
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
        export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/Contents/Home
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

    Cygwin)
        export DISPLAY=:0
        alias cp='\cp -i'
        alias mv='\mv -i'
        alias grep='\grep --color'
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
alias gl='\ls -1rt * | xargs grep -si --color'
alias gl_cs='\ls -1rt * | xargs grep -s --color'
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
alias rmbak='find . \( -iname "core" -o -iname "#*#" -o -iname "*.bak" -o -iname ".*.bak" -o -iname "*.swp" -o -iname "*~" -o -iname ".*~" \) -type f -print -exec rm -f {} \;'
alias rm._='find . \( -iname "._*" -o -iname ".DS_Store" -o -iname "Thumbs.db" -o -iname "Thumbs.db:encryptable"  \) -type f -print -exec rm -f {} \;'

#command -v foo >/dev/null 2>&1
#[ -x "$(command -v foo)" ]
[ -x "$(command -v arp)" ] || arp() { cat /proc/net/arp; }
[ -x "$(command -v ldd)" ] || ldd() { LD_TRACE_LOADED_OBJECTS=1 $*; }
[ -x "$(command -v less)" ] || alias more=less

if [ -f ~/.vimrc.czo ]; then
    export MYVIMRC="-u ~/.vimrc.czo"
elif [ -f ~/.vimrc ]; then
    export MYVIMRC="-u ~/.vimrc"
else
    export MYVIMRC=""
fi
[ -x "$(command -v nvim)" ] && alias vim="\nvim $MYVIMRC"
[ -x "$(command -v vim)"  ] && alias vim="\vim  $MYVIMRC"
[ -x "$(command -v vimx)" ] && alias vim="\vimx $MYVIMRC"
alias nvim="\nvim $MYVIMRC"
alias ne='\emacs -nw'

if [ -f ~/.tmux.conf.czo ]; then
    export MYTMUXRC="-f ~/.tmux.conf.czo"
elif [ -f ~/.tmux.conf ]; then
    export MYTMUXRC="-f ~/.tmux.conf"
else
    export MYTMUXRC=""
fi
alias tmux="\tmux $MYTMUXRC"
alias tmuxa="\tmux $MYTMUXRC attach -t 0"
alias aa="\tmux $MYTMUXRC attach -d || \tmux $MYTMUXRC new"
# resets the terminal mouse when tmux crashes
alias r='tput rs2'

alias screena='screen -d -R'
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

alias ipl='echo $(wget -q -O- http://czo.free.fr/ip.php)'
alias ipa='ip a | grep "inet "'
alias ifa='ifconfig | grep "inet "'

alias mount_list='P="mount | grep -v \" /sys\| /run\| /net\| /snap\| /proc\| /dev\""; echo "Runing: $P"; eval "$P"'
alias rsync_sys='echo "mount --bind / /mnt/rootfs ; then do rsync_full with/without -x..."'
alias rsync_full='rsync --numeric-ids -S -H --delete -av'
alias rsync_fat='rsync --no-p --no-g --modify-window=1 --delete -av -L'
alias rsync_normal='rsync --delete -av'
alias zpool_history='zpool history | grep -v "zfs destroy\|zfs snapshot\|zpool status\|zpool scrub\|zpool import\|zpool export\|zfs send\|zfs receive"'

## My dotconfig files
# curl -k
# wget --no-check-certificate
# config:  https://git.io/JU6cm
# ssh:     https://git.io/JU6c2
# preseed: http://git.io/JkHdk
alias curl_config_fast_copy='curl -fsSL https://raw.githubusercontent.com/czodroid/dotfiles/master/config-fast-copy | sh'
alias curl_config_fast_ssh='curl -fsSL https://raw.githubusercontent.com/czodroid/dotfiles/master/config-fast-ssh | sh'
alias wget_config_fast_all_woc='wget --no-check-certificate -qO- https://raw.githubusercontent.com/czodroid/dotfiles/master/config-debian-preseed | sh'

alias mail_test_root='date | mail -s "CZO, from $USER@$HOSTNAME, $(date +%Y-%m-%d\ %H:%M), do not reply" root'

alias passwd_md5='openssl passwd -1 '
alias passwd_sha512='openssl passwd -6 '
alias dig_lartha='curl -k https://lartha/hosts.html'
alias ssha='eval $(ssh-agent); ssh-add; echo; echo "To add another identity:"; echo "ssh-add ~/.ssh/id_rsa_czo@bunnahabhain"'
ssh_tmux() { ssh -t $@ 'tmux attach -d || tmux new'; }
alias tmate_ssh='tmate -S ${TMPDIR}/tmate.sock new-session -d ; tmate -S ${TMPDIR}/tmate.sock wait tmate-ready ; tmate -S ${TMPDIR}/tmate.sock display -p "#{tmate_web}%n#{tmate_ssh}"'
# sed -i 173d ~/.ssh/known_hosts is working under linux,
# but on FreeBSD you must have gnu-sed, so perl is best!
remove_known_hosts_line() { perl -ni -e "print unless $. == $1 " ~/.ssh/known_hosts; }

alias tree-cvs='tree -adn | grep -v CVS'
alias dft='df -hPT'

alias cvu='cd ~/etc ; cvs up ; cd -'
alias cvd='cd ~/etc ; cvs diff | colordiff ; cd -'
alias cvc='cd ~/etc ; cvs ci -mupdate ; cd -'
cvsdiff() { F=$1 ; cvs diff $(cvs log $F | grep "^revision" | sed -e "s/^revision/-r/" -e 1q) $F; }
cvsadddir() { find $1 -type d \! -name CVS -exec cvs add '{}' \; && find $1 \( -type d -name CVS -prune \) -o \( -type f -exec echo cvs add '{}' \; \); }

alias gtu='git pull'
alias gtd='git diff'
alias gtc='git commit -a -mupdate ; git push'
alias gts='git status'
alias gta='git add .'
alias gtf='git fetch; git diff master origin/master'
alias gtp='git gc'

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

# archlinux
alias PU='pacman --noconfirm -Sy archlinux-keyring && pacman --noconfirm -Su && { yes | pacman -Scc; } && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'
alias PI='pacman -Sy'
alias PP='pacman -Rs'
alias PS='pacman -Ss'
alias PW='pacman -Qi'
alias PL='pacman -Ql'
alias PF='pacman -Qo'

# freebsd
alias FU='pkg update && pkg upgrade && pkg clean && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'

# brew macos
alias BU='brew update && brew upgrade && brew cleanup && sudo sh -c "echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate"'

# choco windows
alias WU='choco upgrade all -y && cyg-get.bat /upgrade all && echo $(date +%Y-%m-%d) > /etc/lsb-czo-updatedate'

# openwrt: opkg
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

sq() { SB=`perl -mDigest::MD5=md5_hex -e 'print qq+squeezelite -o pulse -n $ARGV[0] -m + . join(qq+:+, substr(md5_hex(qq+$ARGV[0]+),0,12) =~ /(..)/g)' $HOSTNAME` ; echo $SB ; $SB & }

## VERY OLD FASHIONED
alias RemeberThis_git_sort='git rev-list --objects --all | git cat-file --batch-check="%(objecttype) %(objectname) %(objectsize) %(rest)" | awk "/^blob/ {print substr(\$0,6)}" | sort --numeric-sort --key=2 | cut --complement --characters=13-40 | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=neares'
alias RemeberThis_ssh-keygen-passwd='ssh-keygen -p -f id_rsa'
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

# preexec Executed just after a command has been read and is about to be executed
preexec() {
    emulate -L zsh
    local -a cmd; cmd=(${(z)1})
    title "$cmd[1]:t $cmd[2,-1] (${USER}@${HOSTNAME})"
}

# don't work!
# zshaddhistory() {
#     print -sr "${(z)1%%$'\n'}"
#     return 1
# }

if [[ -x /usr/lib/command-not-found ]]; then
    command_not_found_handler() {
        [[ -x /usr/lib/command-not-found ]] || return 1
        /usr/lib/command-not-found -- ${1+"$1"} && :
    }
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

SHELLNAME='zsh'

PS1=$'%{\e[m%}\n%{\e[0;97m%}[${PLATFORM}/${SHELLNAME}] - %D{.%Y%m%d_%Hh%M} - ${TERM}:%y:sh${SHLVL} - %(?:%{\e[0;97m%}:%{\e[0;91m%})[%?]%{\e[m%}\n%{\e[0;9${USER_PROMPT_COLOR}m%}${USER}%{\e[0;97m%}@%{\e[0;9${HOST_PROMPT_COLOR}m%}${HOSTNAME}%{\e[0;97m%}:%{\e[0;95m%}$PWD%{\e[m%}\n%{\e[0;97m%}>>%{\e[m%} '

# limit -s
# ulimit unlimited

# busybox has no stty on openWRT!
[ -x "$(command -v stty)" ] && stty -ixon

umask 022

export -U PATH

# zprof
if [ -n "$RTMStart" ] ; then echo -n "DEBUG Main:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop ; fi

# EOF

