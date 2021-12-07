#             ,,,
#            (o o)
####=====oOO--(_)--OOO==============================================####
#
# Filename: .zshrc
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: April 1996
# Last Modified: lundi 06 décembre 2021, 15:05
# Edit Time: 130:55:19
# Description:
#         ~/.zshrc is sourced in interactive shells.
#         This is Alex Fenyo, my guru, who made me discover this
#         amazing shell in 1996... I am forever grateful to him.
#         rm ~/.zshenv ~/.zprofile ~/.zlogin ~/.zsh_history
#         and put instead .profile
#
# $Id: .zshrc,v 1.332 2021/12/06 16:33:32 czo Exp $

# zmodload zsh/zprof

##======= Zsh Settings ===============================================##

setopt ALWAYS_TO_END          # On completion go to end of word
setopt AUTO_CD                # Directory as command does cd
setopt AUTO_PUSHD             # cd uses directory stack too
#setopt CD_SILENT              # Never print the working directory
setopt COMBINING_CHARS        # Displays combining characters correctly
setopt COMPLETE_IN_WORD       # Completion works inside words
setopt EXTENDED_GLOB          # See globbing section above
setopt GLOB_COMPLETE          # Patterns are active in completion
setopt NO_GLOB_DOTS           # Patterns may match leading dots
setopt HIST_IGNORE_ALL_DUPS   # Remove all earlier duplicate lines
setopt HIST_REDUCE_BLANKS     # Trim multiple insgnificant blanks
setopt HIST_SAVE_NO_DUPS      # Remove duplicates when saving
setopt INTERACTIVE_COMMENTS   # Dash on interactive line for comment
setopt INTERACTIVE            # Shell is interactive
setopt LONG_LIST_JOBS         # More verbose listing of jobs
setopt MONITOR                # Shell has job control enabled
setopt NO_BG_NICE             # (!*)Background jobs at lower priority
setopt NO_CHECK_JOBS          # (!*)Check jobs before exiting shell
setopt NO_HUP                 # (!*)Send SIGHUP to proceses on exit
setopt PROMPT_SUBST           # $ expansion etc. in prompts
setopt PUSHD_IGNORE_DUPS      # Don’t push dir multiply on stack
setopt PUSHD_MINUS            # Reverse sense of – and + in pushd
setopt RM_STAR_SILENT         # Don’t warn on rm *
setopt SH_WORD_SPLIT          # Split non­array variables yuckily

export TMPDIR=${TMPDIR-/tmp}
#android
#export TMPDIR=${TMPDIR-/data/local/tmp}

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
  if ((REGION_ACTIVE)) then
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

##======= Completions ================================================##

# WARNING: it doesn't work...
# error in completer _complete _ignored with no correct or approximate

autoload -Uz compinit
compinit
#compinit -d ${HOME}/.zcompdump-${HOSTNAME}-${ZSH_VERSION}
#compinit -C

zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact-dirs true
# cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcomp
# for use with expand-or-complete
#zstyle ':completion:*' completer _complete _match _prefix:-complete _list _correct _approximate _prefix:-approximate _ignored
#zstyle ':completion:*' completer _complete _match _prefix:-complete _list _ignored
zstyle ':completion:*' completer _complete _ignored
# _list anywhere to the completers always only lists completions on first tab
zstyle ':completion:*:prefix-complete:*' completer _complete
zstyle ':completion:*:prefix-approximate:*' completer _approximate
# configure the match completer, with original set to only it doesn't act like a `*' was inserted at the cursor position
zstyle ':completion:*:match:*' original only
# first case insensitive completion, then case-sensitive partial-word c., then case-insensitive (with -_. as possible anchors)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[-_.]=* r:|=*' 'm:{a-z}={A-Z} r:|[-_.]=* r:|=*'
# allow 2 erros in correct completer
zstyle ':completion:*:correct:*' max-errors 2 not-numeric
# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) numeric )'

# meu selection with 2 candidates or more
zstyle ':completion:*' menu select=2
# Add colors in completions
#zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# messages/warnings format
zstyle ':completion:*' verbose yes
zstyle ':completion:*:corrections'  format $' %{\e[0;93m%}-- %d (errors: %e) --%{\e[m%}'
zstyle ':completion:*:descriptions' format $' %{\e[0;92m%}-- %d --%{\e[m%}'
zstyle ':completion:*:messages'     format $' %{\e[0;91m%}-- %d --%{\e[m%}'
zstyle ':completion:*:warnings'     format $' %{\e[0;93m%}-- no matches for: %d --%{\e[m%}'
# make completions appear below the description of which listing they come from
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' select-prompt %SScrolling active: current selection at %p%s

# completion of commands
zstyle ':completion:*:*:kill:*' command 'ps -u$USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:killall:*' command 'ps -u$USER -o cmd'
#zstyle ':completion:*:(ssh|scp):*' tag-order    hosts-ports-users hosts users-hosts users hosts
#zstyle ':completion:*:(ssh|scp):*' group-order  hosts-ports-users hosts users-hosts users hosts

if [ "$PLATFORM" = "Cygwin" ]
then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
    zstyle ':completion:*:complete:-command-:*:commands' ignored-patterns '(^(*.(#i)(exe|com|bat|pl)))'
    zstyle ':completion:*' completer _complete _ignored
fi

if [ "$PLATFORM" = "Darwin" ]
then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
fi


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

    FreeBSD) PLATFORM=FreeBSD ;;

    OpenBSD) PLATFORM=OpenBSD ;;

    NetBSD)  PLATFORM=NetBSD ;;

    HP-UX)   PLATFORM=HPUX ;;

    OSF1)    PLATFORM=OSF ;;

    CYGWIN*) PLATFORM=Cygwin ;;

    Darwin)  PLATFORM=Darwin ;;

    *)       PLATFORM=Unknown ;;

esac

export PLATFORM


##======= Paths ======================================================##

# Super big path pour Linux, FreeBSD, SunOS, Solaris

#FIXME: typeset -U for bash
export PATH=$HOME/.local/bin:$HOME/etc/shell:/usr/local/bin:/usr/pkg/bin:/usr/local/ssh/bin:/usr/local/adm:/usr/local/etc:/usr/local/games:/usr/local/sbin:/sbin:/bin:/usr/bin:/usr/5bin:/usr/X11/bin:/usr/X11R6/bin:/usr/X11R5/bin:/usr/andrew/bin:/usr/bin/X11:/usr/bin/games:/usr/ccs/bin:/usr/dt/bin:/usr/etc:/usr/games:/usr/lang/bin:/usr/lib:/usr/lib/teTeX/bin:/usr/libexec:/usr/mail/bin:/usr/oasys/bin:/usr/openwin/bin:/usr/sadm/bin:/usr/sbin:/usr/ucb:/usr/ucb/bin:/usr/share/bin:/usr/snadm/bin:/usr/vmsys/bin:/usr/xpg4/bin:/opt/bin:/usr/lib/gmt/bin:$PATH

## config cpan perl libs not in distro
#export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
#export PERL_MB_OPT="--install_base $HOME/perl5";
#export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
#export PERL5LIB="$HOME/perl5/lib/perl5/i686-linux-gnu-thread-multi-64int:$HOME/perl5/lib/perl5";
#export PATH="$HOME/perl5/bin:$PATH";

## config android
#export PATH=$HOME/Android/Sdk/tools:${PATH}
#export PATH=$HOME/Android/Sdk/platform-tools:${PATH}
#export PATH=$HOME/Android/Sdk/ndk-bundle:${PATH}
#export PATH=/opt/android-studio/bin:${PATH}

## config openwrt
if [ -d /rom/bin ] 
then
    export PATH=${PATH}:/rom/bin
fi

## config termux for android
if [ -d /system/bin ] 
then
    export PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets:/system/bin:/system/xbin:/system/bin:/system/xbin:${PATH}
    export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
fi

## config SWARM
#export PATH=/users/project/swarm/data/tools/IpgpSoftwareTools:/users/project/swarm/data/tools/CommonSoftwareTools:$PATH

# there was a time when I needed it, but I can't remember anymore...
#typeset -U MANPATH=$HOME/local/share/man:/usr/pkg/man:/usr/man:/usr/local/man:/usr/local/lib/gcc-lib/man:/usr/local/lib/perl5/man:/usr/local/lib/texmf/man:/usr/man/preformat:/usr/openwin/man:/usr/share/man:/usr/5bin/man:/usr/X11/man:/usr/X11R6/man:/usr/dt/man:/usr/lang/man:$MANPATH
#export MANPATH

# export LD_RUN_PATH=/users/soft5/gnu/bazar/archi/Linux/lib/wxgtk/lib

export -U PATH


##======= Environment Variables ======================================##

{ [ -x "$(command -v hostname)" ] && export HOSTNAME=$(hostname 2>/dev/null); } || export HOSTNAME=$(uname -n 2>/dev/null)
export HOSTNAME=$(echo "$HOSTNAME" | sed 's/\..*//')

{ [ -x "$(command -v whoami)" ] && USER=$(whoami 2>/dev/null); } || USER=$(id -nu 2>/dev/null) || [ -n "$USER" ]
export USER

# GNU ls
export LS_COLORS='no=00:fi=00:di=94:ln=96:pi=30;104:so=37;45:do=30;105:bd=30;42:cd=30;102:or=31;107:su=37;41:sg=30;43:tw=37;44:ow=30;44:st=30;46:ex=97:*.7z=91:*.ace=91:*.alz=91:*.arc=91:*.arj=91:*.bz2=91:*.bz=91:*.cab=91:*.cpio=91:*.deb=91:*.dwm=91:*.dz=91:*.ear=91:*.esd=91:*.gz=91:*.jar=91:*.lha=91:*.lrz=91:*.lz4=91:*.lz=91:*.lzh=91:*.lzma=91:*.lzo=91:*.rar=91:*.rpm=91:*.rz=91:*.sar=91:*.swm=91:*.t7z=91:*.tar=91:*.taz=91:*.tbz2=91:*.tbz=91:*.tgz=91:*.tlz=91:*.txz=91:*.tz=91:*.tzo=91:*.tzst=91:*.war=91:*.wim=91:*.xz=91:*.z=91:*.Z=91:*.zip=91:*.zoo=91:*.zst=91:*.bmp=95:*.cgm=95:*.emf=95:*.flc=95:*.fli=95:*.gif=95:*.icns=95:*.ico=95:*.jpeg=95:*.jpg=95:*.mng=95:*.pbm=95:*.pcx=95:*.pgm=95:*.png=95:*.ppm=95:*.svg=95:*.svgz=95:*.tga=95:*.tif=95:*.tiff=95:*.webp=95:*.xbm=95:*.xcf=95:*.xpm=95:*.xwd=95:*.asf=35:*.avi=35:*.flv=35:*.m2v=35:*.m4v=35:*.mjpeg=35:*.mjpg=35:*.mkv=35:*.mov=35:*.mp4=35:*.mp4v=35:*.mpeg=35:*.mpg=35:*.nuv=35:*.ogm=35:*.ogv=35:*.ogx=35:*.qt=35:*.rm=35:*.rmvb=35:*.vob=35:*.webm=35:*.wmv=35:*.aac=36:*.au=36:*.flac=36:*.m4a=36:*.mid=36:*.midi=36:*.mka=36:*.mp3=36:*.mpc=36:*.oga=36:*.ogg=36:*.opus=36:*.ra=36:*.spx=36:*.wav=36:*.xspf=36:*.doc=92:*.docx=92:*.odp=92:*.ods=92:*.odt=92:*.pdf=92:*.ppt=92:*.pptx=92:*.xls=92:*.xlsx=92:*.bat=93:*.c=93:*.C=93:*.cc=93:*.cl=93:*.cmd=93:*.coffee=93:*.cpp=93:*.csh=93:*.css=93:*.csv=93:*.cxx=93:*.el=93:*.erb=93:*.f90=93:*.f=93:*.F=93:*.go=93:*.h=93:*.haml=93:*.hh=93:*.hpp=93:*.hs=93:*.htm=93:*.html=93:*.java=93:*.js=93:*.l=93:*.latex=93:*.less=93:*.log=93:*.mak=93:*.make=93:*.man=93:*.md=93:*.n=93:*.objc=93:*.p=93:*.perl=93:*.php=93:*.pl=93:*.pm=93:*.pod=93:*.py=93:*.python=93:*.rb=93:*.rdf=93:*.sass=93:*.scss=93:*.sh=93:*.shtml=93:*.sql=93:*.sv=93:*.svh=93:*.tex=93:*.txt=93:*.v=93:*.vh=93:*.vhd=93:*.vim=93:*.xml=93:*.zsh=93:'

# BSD ls
export LSCOLORS='ExGxfxFxHxacabxDxeae'

export LESS='-i -j5 -PLine\:%lb/%L (%pb\%) ?f%f:Standard input. [%i/%m] %B bytes'
export PAGER=less
export PERLDOC_PAGER='less -R'

export PGPPATH=$HOME/.gnupg

export EDITOR=vim
export CVSEDITOR=vim
export RSYNC_RSH=ssh

export CVSROOT=czo@ananas:/tank/data/czo/CzoDoc/cvsroot

case $(domainname 2>/dev/null) in
    NIS-CZO*) export PRINTER=U172-magos ;;
    *) export PRINTER=BW_Pigeonnier_ananas ;;
esac

export HTML_TIDY=$HOME/.tidyrc


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

# csh compatibility env set
setenv() { export $1=$2; }
# v() { set | grep -ai $1; }

case $PLATFORM in

    Linux*)
        alias cp='\cp -i'
        alias mv='\mv -i'
        alias grep='\grep --color'
        alias pgrep='\pgrep -af'
        { \ps -eaf >/dev/null 2>&1 && alias ps='\ps -eaf'; } || alias ps='\ps -w'
        { \ls -l --time-style=long-iso >/dev/null 2>&1 && alias ls='\ls --time-style=long-iso --color=auto -a'; } || alias ls='\ls --color=auto -a'
        ;;

    FreeBSD)
        alias grep='\grep --color'
        alias ps='\ps -Awww'
        { [ -x "$(command -v gnuls)" ] && alias ls='\gnuls --time-style=long-iso --color=auto -a'; } || alias ls='\ls -G -a'
        ;;

    NetBSD | OpenBSD)
        alias ps='\ps -Awww'
        { [ -x "$(command -v gnuls)" ] && alias ls='\gnuls --time-style=long-iso --color=auto -a'; } || alias ls='\ls -a'
        ;;

    Darwin)
        export DISPLAY=:0
        export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
        ## config macos brew
        export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:$PATH
        alias grep='\grep --color'
        alias ps='\ps -Awww'
        { [ -x "$(command -v gls)" ] && alias ls='\gls --time-style=long-iso --color=auto -a'; } || alias ls='\ls -G -a'
        ;;

    SunOS | Solaris)
        alias ps='\ps -ef'
        alias ls='\ls -a'
        ;;

    Cygwin)
        export DISPLAY=localhost:0
        alias cp='\cp -i'
        alias mv='\mv -i'
        alias grep='\grep --color'
        alias ps='\ps -aflW'
        alias ls='\ls --time-style=long-iso --color=auto -a'
        ;;

esac

alias rule='echo "....|....1....|....2....|....3....|....4....|....5....|....6....|....7....|....8....|....9" '

#alias ls='\ls --time-style=long-iso --color=auto -a'
alias ll='ls -l'
alias lh='ls -lh'
alias l='ls -alrt'
alias g='grep -si'

alias llt='find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -printf "%TF_%TR %5m %10s %p\n" | sort -n'
alias lls='find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -printf "%s %TF_%TR %5m %p\n" | sort -n'
alias llx='find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -perm -1 -print | sort'
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

[ -x "$(command -v nvim)" ] && alias vim='\nvim -u ~/.vimrc'
[ -x "$(command -v vimx)" ] && alias vim=vimx
{ [ -x "$(command -v vim)" ] && alias vi=vim; } || alias vi="vi -u NONE"
alias nvim='nvim -u ~/.vimrc'
alias ne='emacs -nw'

psg() { ps | grep -i $1 | sort -r -k 3 | grep -v "grep \!*\|sort -r -k 3"; }

n() { ncd $*; if [ $? -eq 0 ]; then cd "$(cat "$HOME/.ncd_sdir")"; fi; }

alias wgetr='wget -m -np -k -r'
alias wgetp='wget -m -np -k -l1'

# vieux truc 'chmod -R 755 . ; find . -type f -print0 | xargs -0 chmod 644'
alias chmodr='chmod -R a-st,u+rwX,g+rX-w,o+rX-w .'
alias chmodg='chmod -R a-st,u+rwX,g+rwX,o+rX-w .'

alias tara='\tar -czf'
alias tarx='\tar -xf'
alias tarxiso='cmake -E tar xf'
#alias tarxiso='bsdtar -xf'
alias tsu='su - -c "cd /; /data/data/com.termux/files/usr/bin/bash --rcfile /data/data/com.termux/files/home/.bashrc"'

listext() { perl -e 'use File::Find (); File::Find::find(\&wanted, "."); sub wanted { if ((-f $_)) { $ext=$File::Find::name; $ext=~s,^.*\.,,; $list{$ext}++; } } foreach $key (sort {$list{$a} <=> $list{$b}} keys %list) { printf "$key : $list{$key}\n"; }'; }

alias ipl='echo $(wget -q -O- http://czo.free.fr/ip.php)'
alias ipa='ip a | grep "inet "'
alias ifa='ifconfig | grep "inet "'

alias screena='screen -d -R'
alias tmuxa='tmux attach -d || tmux new'
alias aa='tmux attach -d || tmux new'

alias mount_list='P="mount | grep -v \" /sys\| /run\| /net\| /snap\| /proc\| /dev\""; echo "Runing: $P"; eval "$P"'
alias rsync_sys='echo "mount --bind / /mnt/rootfs ; puis faire rsyncfull avec/sans -x..."'
alias rsync_full='rsync --numeric-ids -S -H --delete -av'
alias rsync_fat='rsync --no-p --no-g --modify-window=1 --delete -av -L'

alias curl_config_fast_copy='curl -fsSL https://git.io/JU6cm | sh'
alias curl_config_fast_ssh='curl -fsSL https://git.io/JU6c2 | sh'
alias wget_config_fast_all='wget --no-check-certificate -qO- http://git.io/JkHdk | sh'

alias mail_test_root='date | mail -s "CZO, from $USER@$HOSTNAME, $(date +%Y-%m-%d\ %H:%M), do not reply" root'

alias passwd_md5='openssl passwd -1 '
alias passwd_sha512='openssl passwd -6 '
alias dig_lartha='curl -k https://lartha/hosts.html'
alias ssha='eval $(ssh-agent); ssh-add; /bin/echo -e "\nTo add another identity:\nssh-add ~/.ssh/id_rsa_czo@bunnahabhain"'
ssh_tmux() { ssh -t $@ 'tmux attach -d || tmux new'; }
alias tmate_ssh='tmate -S ${TMPDIR}/tmate.sock new-session -d ; tmate -S ${TMPDIR}/tmate.sock wait tmate-ready ; tmate -S ${TMPDIR}/tmate.sock display -p "#{tmate_web}%n#{tmate_ssh}"'
# sed -i 173d ~/.ssh/known_hosts is working under linux,
# but on FreeBSD you must have gnu-sed, so perl is best!
remove_known_hosts_line() { perl -ni -e "print unless $. == $1 " ~/.ssh/known_hosts; }

alias mytree='tree -adn | grep -v CVS'
alias cvu='cd ~/etc ; cvs up ; cd -'
alias cvd='cd ~/etc ; cvs diff ; cd -'
alias cvc='cd ~/etc ; cvs ci -mok ; cd -'
cvsdiff() { F=$1 ; cvs diff $(cvs log $F | grep "^revision" | sed -e "s/^revision/-r/" -e 1q) $F; }
cvsadddir() { find $1 -type d \! -name CVS -exec cvs add '{}' \; && find $1 \( -type d -name CVS -prune \) -o \( -type f -exec echo cvs add '{}' \; \); }

alias gtl='git pull'
alias gts='git status'
alias gtd='git diff'
alias gtf='git fetch; git diff master origin/master'
alias gta='git add .'
alias gtc='git commit -mok -a'
alias gtp='git push'

alias pkg_inst_debian="aptitude search '~i !~M' -F %p | LANG=C sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_inst_debian2="dpkg-query -W --showformat='"\$"{Package}\n' | LANG=C sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_inst_redhat="rpm -qa --qf '%{NAME}\n' | LANG=C sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_inst_arch="pacman -Qe | awk '{print \$1}' | LANG=C sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"

# debian, ubuntu
alias AU='aptitude update && aptitude upgrade && aptitude clean'
alias AI='aptitude install'
alias AP='aptitude purge'
alias AS='aptitude search'
alias ASS='apt-cache search'
alias AL='dpkg -L'
alias AF='dpkg -S'

# redhat, fedora
alias YU='yum update && yum clean all'
alias YI='yum install'
alias YP='yum remove'
YS() { yum list "*$1*"; }
alias YSS='yum search'
alias YL='rpm -ql'
alias YF='rpm -qf'

# archlinux
alias PU='pacman -Syu'
alias PI='pacman -S'
alias PP='pacman -Rs'
alias PS='pacman -Ss'
alias PL='pacman -Ql'
alias PF='pacman -Qo'

# openwrt: opkg
# suse: zypper
# freebsd: pkg
# netbsd: pkgin

alias sun='export TERM=sun-cmd ; echo TERM=$TERM'
alias vt100='export TERM=vt100 ; echo TERM=$TERM'
alias xte='export TERM=xterm ; echo TERM=$TERM'
alias xts='export TERM=screen ; echo TERM=$TERM'
alias xtc='export TERM=xterm-color ; echo TERM=$TERM'
alias xtc256='export TERM=xterm-256color ; echo TERM=$TERM'

alias console_color='/bin/echo -e "\e]P0282828\e]P1cc241d\e]P298971a\e]P3d79921\e]P4458588\e]P5b16286\e]P6689d6a\e]P7c9b788\e]P84a4239\e]P9fb4934\e]PAb8bb26\e]PBfabd2f\e]PC83a598\e]PDd3869b\e]PE8ec07c\e]PFfbf1c7" ; clear'
alias console_color_cursor='/bin/echo -ne "\e]12;#98971a\a"'
alias 16color='for i in $(seq 0 7); do printf "\x1b[48;5;${i}m  "; done; printf "\x1b[0m\n"; for i in $(seq 8 15); do printf "\x1b[48;5;${i}m  "; done; printf "\x1b[0m\n";'

passwd_simple_encrypt() { perl -e 'print unpack("H*",  join("", map {$_^"*"} split(//,$ARGV[0])))."\n"' $1; }
passwd_simple_decrypt() { perl -e 'print join("",map{$_^"*"}split(//,pack("H*",$ARGV[0])))."\n"' $1; }

sb() { perl -mDigest::MD5=md5_hex -e 'print qq+squeezelite -n $ARGV[0] -m + . join(qq+:+, substr(md5_hex(qq+$ARGV[0]+),0,12) =~ /(..)/g)' $HOSTNAME | sh ; }

## VERY OLD FASHIONED
alias RemeberThis_kfm='setxkbmap fr mac'
alias RemeberThis_edl='export DISPLAY=localhost:0'
alias RemeberThis_remove_empty_line_and_slash_and_print="perl -n -e 'print unless m/^\s*#|^\s*$/'"
alias RemeberThis_export_svg2png='inkscape --export-width=128 --export-height=128 --export-png=icon.png icon.svg'
alias RemeberThis_slax_create_mksquashfs='mksquashfs . ../99-czo.sb -comp xz -Xbcj x86'
alias RemeberThis_macbook_kbd_bright_30='echo 30 > /sys/class/leds/smc\:\:kbd_backlight/brightness'
alias RemeberThis_macbook_vid_bright_30='echo 30 > /sys/class/backlight/acpi_video0/brightness'
alias RemeberThis_utf8_redode_this_directory="file -i * | grep iso-8859 | sed 's/:.*//' | xargs recode -t LATIN1..UTF-8"
alias RemeberThis_whatsappjpg='mogrify -resize 1918800@ -quality 75 *.jpg'
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


##======= Main ======================================================##

title() {
    case "$TERM" in
        xterm* | rxvt*)
            printf "\033]0;%s\007" "$*"
            ;;
        screen*)
            printf "\033k%s\033\\" "$*"
            printf "\033]0;%s\007" "$*"
            ;;
    esac
}

# precmd Executed before each prompt.
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

if [[ -x /usr/lib/command-not-found ]] ; then
    command_not_found_handler() {
        [[ -x /usr/lib/command-not-found ]] || return 1
        /usr/lib/command-not-found -- ${1+"$1"} && :
    }
fi

#HOSTNAME=czophone
#USER=root

# busybox has no cksum on openWRT!
if [ -x "$(command -v cksum)" ]
then
    # hash for colors
    USER_PROMPT_COLOR=$( /bin/echo -n "AA$USER" | cksum | awk '{ print ((( $1  + 2 ) % 6 ) + 1 ) }' )
    # export for screen
    export HOST_PROMPT_COLOR=$( /bin/echo -n "JC$HOSTNAME" | cksum | awk '{ print ((( $1  + 1 ) % 6 ) + 1 ) }' )
else
    USER_PROMPT_COLOR="1"
    export HOST_PROMPT_COLOR="5"
fi
# export for screen
export HOST_PROMPT_SIZE="%-0$(( $( echo "$HOSTNAME" | wc -c ) + 17 ))="

BVERS=$(echo '$Id: .zshrc,v 1.332 2021/12/06 16:33:32 czo Exp $' | sed -e 's/^.*,v 1.//' -e 's/ .*$//' 2>/dev/null)
SHELLNAME='zsh'

PS1=$'%{\e[m%}\n%{\e[0;97m%}[${PLATFORM}/${SHELLNAME}] - %D{.%Y%m%d_%Hh%M} - ${TERM}:%y:sh${SHLVL} - %(?:%{\e[0;97m%}:%{\e[0;91m%})[%?]%{\e[m%}\n%{\e[0;9${USER_PROMPT_COLOR}m%}${USER}%{\e[0;97m%}@%{\e[0;9${HOST_PROMPT_COLOR}m%}${HOSTNAME}%{\e[0;97m%}:%{\e[0;95m%}$PWD%{\e[m%}\n%{\e[0;97m%}>>%{\e[m%} '

# limit -s
# ulimit unlimited

# busybox has no stty on openWRT!
[ -x "$(command -v stty)" ] && stty -ixon

umask 022

export -U PATH

# zprof
# EOF

