#             ,,,
#            (o o)
####=====oOO--(_)--OOO==============================================####
#
# Filename: .bashrc
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0
# File Created: November 2005
# Last Modified: vendredi 12 mars 2021, 18:48
# Edit Time: 77:13:41
# Description:
#         ~/.bashrc is executed by bash for non-login shells.
#         tries to mimic my .zshrc and to be 2.05 compatible
#         for old wkstations
#         rm ~/.bash_profile ~/.bash_login ~/.bash_history
#         and put instead .profile
#
# $Id: .bashrc,v 1.288 2021/03/16 14:16:46 czo Exp $

#set -v
#set -x

##======= Bash Settings ==============================================##

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# echo -n "DEBUG T1:"; date

export TMPDIR=${TMPDIR-/tmp}
#android
#export TMPDIR=${TMPDIR-/data/local/tmp}

export HISTFILE=${TMPDIR}/.sh_history

if [ -n "$BASH_VERSION" ]; then
    #busybox ash bug when defining HISTFILE...
    export HISTFILE=$HOME/.sh_history
    # olivier, repasse a zsh ...
    export HISTFILESIZE=35000
    export HISTSIZE=30000
    export HISTCONTROL=ignoreboth:erasedups
#avoid overwriting history
#shopt -s histappend
#export HISTTIMEFORMAT='%F %T '
#BASHBUG history remove duplicates
fi

export TIMEFORMAT=$'\n%3lR real    %3lU user    %3lS system    %P%%'

#BASHMISSING
# removed zsh preexec implementation of REPORTTIME, see rev 1.32

if [ -n "$BASH_VERSION" ]; then
    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize
fi


##======= Platform ===================================================##

PLATFORM=Unknown

case $(uname 2>/dev/null) in

    Linux*)
        case $(uname -m 2>/dev/null) in
            i*86)   PLATFORM=Linux_x86 ;;
            x86_64) PLATFORM=Linux ;;
            mips)   PLATFORM=Linux_mips ;;
            arm*)   PLATFORM=Linux_arm ;;
            aarch*) PLATFORM=Linux_aarch ;;
        esac
        ;;

    SunOS*)
        case $(uname -r 2>/dev/null) in
            5*) PLATFORM=Solaris ;;
            *)  PLATFORM=SunOS ;;
        esac
        ;;

    FreeBSD*) PLATFORM=FreeBSD ;;

    NetBSD*)  PLATFORM=NetBSD ;;

    HP-UX*)   PLATFORM=HPUX ;;

    OSF1*)    PLATFORM=OSF ;;

    CYGWIN*)  PLATFORM=Cygwin ;;

    Darwin*)  PLATFORM=Darwin ;;

    *)        PLATFORM=Unknown ;;

esac

export PLATFORM

##======= Paths ======================================================##

# Super big path pour Linux, FreeBSD, SunOS, Solaris

#FIXME: typeset -U for bash
export PATH=/system/bin:/system/xbin:/users/project/swarm/data/tools/IpgpSoftwareTools:/users/project/swarm/data/tools/CommonSoftwareTools:$HOME/bin:$HOME/.local/bin:$HOME/local/${PLATFORM}/bin:$HOME/etc/shell:/usr/local/bin:/usr/pkg/bin:/usr/local/ssh/bin:/usr/local/adm:/usr/local/etc:/usr/local/games:/usr/local/sbin:/sbin:/bin:/usr/bin:/usr/5bin:/usr/X11/bin:/usr/X11R6/bin:/usr/X11R5/bin:/usr/andrew/bin:/usr/bin/X11:/usr/bin/games:/usr/ccs/bin:/usr/dt/bin:/usr/etc:/usr/games:/usr/lang/bin:/usr/lib:/usr/lib/teTeX/bin:/usr/libexec:/usr/mail/bin:/usr/oasys/bin:/usr/openwin/bin:/usr/sadm/bin:/usr/sbin:/usr/ucb:/usr/ucb/bin:/usr/share/bin:/usr/snadm/bin:/usr/vmsys/bin:/usr/xpg4/bin:/opt/bin:/usr/lib/gmt/bin:$PATH

## config cpan perl libs not in distro
#export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
#export PERL_MB_OPT="--install_base $HOME/perl5";
#export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
#export PERL5LIB="$HOME/perl5/lib/perl5/i686-linux-gnu-thread-multi-64int:$HOME/perl5/lib/perl5";
#export PATH="$HOME/perl5/bin:$PATH";

## config android
export PATH=$HOME/Android/Sdk/tools:${PATH}
export PATH=$HOME/Android/Sdk/platform-tools:${PATH}
export PATH=$HOME/Android/Sdk/ndk-bundle:${PATH}
export PATH=/opt/android-studio/bin:${PATH}

## config termux for android
export PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets:/system/bin:/system/xbin:${PATH}
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib

## config macos brew
export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:$PATH

# there was a time when I needed it, but I can't remember anymore...
#typeset -U MANPATH=$HOME/local/share/man:/usr/pkg/man:/usr/man:/usr/local/man:/usr/local/lib/gcc-lib/man:/usr/local/lib/perl5/man:/usr/local/lib/texmf/man:/usr/man/preformat:/usr/openwin/man:/usr/share/man:/usr/5bin/man:/usr/X11/man:/usr/X11R6/man:/usr/dt/man:/usr/lang/man:$MANPATH
#export MANPATH

# export LD_RUN_PATH=/users/soft5/gnu/bazar/archi/Linux/lib/wxgtk/lib

export PATH

##======= Environment Variables ======================================##

{ [ -x "$(command -v getprop)" ] && export HOSTNAME=$(getprop net.hostname 2>/dev/null); } || { [ -x "$(command -v hostname)" ] && export HOSTNAME=$(hostname 2>/dev/null); } || export HOSTNAME=$(uname -n 2>/dev/null)
export HOSTNAME=$(echo "$HOSTNAME" | sed 's/\..*//')

{ [ -x "$(command -v whoami)" ] && USER=$(whoami 2>/dev/null); } || USER=$(id -nu 2>/dev/null) || [ -n "$USER" ]
export USER

export LS_COLORS='no=00:fi=00:di=94:ln=96:pi=30;104:so=37;45:do=30;105:bd=30;42:cd=30;102:or=31;107:su=37;41:sg=30;43:tw=37;44:ow=30;44:st=30;46:ex=97:*.7z=91:*.ace=91:*.alz=91:*.arc=91:*.arj=91:*.bz2=91:*.bz=91:*.cab=91:*.cpio=91:*.deb=91:*.dwm=91:*.dz=91:*.ear=91:*.esd=91:*.gz=91:*.jar=91:*.lha=91:*.lrz=91:*.lz4=91:*.lz=91:*.lzh=91:*.lzma=91:*.lzo=91:*.rar=91:*.rpm=91:*.rz=91:*.sar=91:*.swm=91:*.t7z=91:*.tar=91:*.taz=91:*.tbz2=91:*.tbz=91:*.tgz=91:*.tlz=91:*.txz=91:*.tz=91:*.tzo=91:*.tzst=91:*.war=91:*.wim=91:*.xz=91:*.z=91:*.Z=91:*.zip=91:*.zoo=91:*.zst=91:*.bmp=95:*.cgm=95:*.emf=95:*.flc=95:*.fli=95:*.gif=95:*.icns=95:*.ico=95:*.jpeg=95:*.jpg=95:*.mng=95:*.pbm=95:*.pcx=95:*.pgm=95:*.png=95:*.ppm=95:*.svg=95:*.svgz=95:*.tga=95:*.tif=95:*.tiff=95:*.webp=95:*.xbm=95:*.xcf=95:*.xpm=95:*.xwd=95:*.asf=35:*.avi=35:*.flv=35:*.m2v=35:*.m4v=35:*.mjpeg=35:*.mjpg=35:*.mkv=35:*.mov=35:*.mp4=35:*.mp4v=35:*.mpeg=35:*.mpg=35:*.nuv=35:*.ogm=35:*.ogv=35:*.ogx=35:*.qt=35:*.rm=35:*.rmvb=35:*.vob=35:*.webm=35:*.wmv=35:*.aac=36:*.au=36:*.flac=36:*.m4a=36:*.mid=36:*.midi=36:*.mka=36:*.mp3=36:*.mpc=36:*.oga=36:*.ogg=36:*.opus=36:*.ra=36:*.spx=36:*.wav=36:*.xspf=36:*.doc=92:*.docx=92:*.odp=92:*.ods=92:*.odt=92:*.pdf=92:*.ppt=92:*.pptx=92:*.xls=92:*.xlsx=92:*.bat=93:*.c=93:*.C=93:*.cc=93:*.cl=93:*.cmd=93:*.coffee=93:*.cpp=93:*.csh=93:*.css=93:*.csv=93:*.cxx=93:*.el=93:*.erb=93:*.f90=93:*.f=93:*.F=93:*.go=93:*.h=93:*.haml=93:*.hpp=93:*.hs=93:*.htm=93:*.html=93:*.java=93:*.js=93:*.l=93:*.latex=93:*.less=93:*.log=93:*.man=93:*.md=93:*.n=93:*.objc=93:*.p=93:*.php=93:*.pl=93:*.pm=93:*.pod=93:*.py=93:*.rb=93:*.rdf=93:*.sass=93:*.scss=93:*.sh=93:*.shtml=93:*.sql=93:*.sv=93:*.svh=93:*.tex=93:*.txt=93:*.v=93:*.vh=93:*.vhd=93:*.vim=93:*.xml=93:*.zsh=93'

export LESS='-i -j5 -PLine\:%lb/%L (%pb\%) ?f%f:Standard input. [%i/%m] %B bytes'
export PAGER=less

export PGPPATH=~/.pgp

export EDITOR=vim
export CVSEDITOR=vim
export RSYNC_RSH=ssh

export CVSROOT=ananas:/tank/data/czo/CzoDoc/cvsroot
#export CVSROOT=$HOME/tmp/cvsroot

case $(domainname 2>/dev/null) in
    NIS-CZO*) export PRINTER=U172-magos ;;
    *) export PRINTER=HP_Deskjet_5900_series_ananas ;;
esac
#export PRINTER=U172-magos

export HTML_TIDY=$HOME/.tidyrc

##======= Key bindings ===============================================##

if [ -n "$BASH_VERSION" ]; then

    # view $HOME/.inputrc
    #if [ -f $HOME/.inputrc ]; then
    #    bind -f $HOME/.inputrc
    #fi

    # Be 8 bit clean.
    bind 'set input-meta on'
    bind 'set output-meta on'
    bind 'set convert-meta off'

    # do not bell on tab-completion
    set 'bell-style none'
    #set 'bell-style visible'

    bind 'set show-all-if-ambiguous on'
    bind 'set show-all-if-unmodified on'
    bind 'set completion-query-items 1000'
    bind 'set page-completions off'
    bind 'set colored-stats on'
    bind 'set visible-stats on'
    #bind 'set history-preserve-point on'
    #bind 'set menu-complete-display-prefix on'

    # Czo defines pour mon mac et pc
    bind -x '"\C-xr": "source ~/.bashrc"'
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

    bind '"\C-p":     previous-history'
    bind '"\C-n":     next-history'

    bind '"\e[3~":    delete-char'
    bind '"\C-h":     backward-delete-char'

    bind '"\e[3;3~":  shell-kill-word'
    bind '"\M-h":     shell-backward-kill-word'

    bind '"\e\e":     kill-whole-line'
    bind '"\em":      "\C-w\C-y\C-y"'

fi

##======= Aliases & Functions ========================================##

unalias -a

alias where='type -a'
alias t=where
alias st='source ~/.bashrc'
alias hload='history -r'
alias hsave='history -w'
alias hclear="history -c"
alias hclearlog="echo > /var/log/wtmp ; echo > /var/log/lastlog ; history -c ; "
#to run sometimes, BUG no dup history
alias hb='history -n; history | tac | sed "s/^ *[0-9]\+ \+//" | sed "s/\s\+$//" | perl -ne  "print if not \$x{\$_}++;" | tac > $HISTFILE ; history -c ; history -r'

alias hi='fc -l -9111000'
alias hgrep='fc -l -9111000 | grep'

# csh compatibility env set
setenv() { export $1=$2; }

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
        { [ -x "$(command -v gnuls)" ] && alias ls='\gnuls --time-style=long-iso --color=auto -a'; } || alias ls='\ls --color -a'
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

    Darwin)
        export DISPLAY=:0
        export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
        alias grep='\grep --color'
        alias ps='\ps -Awww'
        { [ -x "$(command -v gls)" ] && alias ls='\gls --time-style=long-iso --color=auto -a'; } || alias ls='\ls --color -a'
        ;;
esac

alias rule='echo "....|....1....|....2....|....3....|....4....|....5....|....6....|....7....|....8....|....9" '

#alias ls='\ls --time-style=long-iso --color=auto -a'
alias ll='ls -l'
alias lh='ls -lh'
alias l='ls -alrt'

alias llt='find . -type f -printf "%TF_%TR %5m %10s %p\n" | sort -n'
alias lls='find . -type f -printf "%s %TF_%TR %5m %p\n" | sort -n'
alias llexe='find . -type f -perm +1 -print'
alias md='\mkdir -p'
mdcd()    { \mkdir -p "$1"  ; cd "$1"; }

alias rmf='rm -fr'
alias rmexe='find . -perm +1 -print -exec rm {} \;'
alias rmemptyf='find . -empty -type f -print -exec rm {} \;'
alias rmemptyd='find . -empty -type d -print -exec rm -fr {} \;'
alias rmbak='find . \( -iname "core" -o -iname "#*#" -o -iname "*.bak" -o -iname ".*.bak" -o -iname "*.swp" -o -iname "*~" -o -iname ".*~" \) -type f -print -exec rm -f {} \;'
alias rm._='find . \( -iname "._*" -o -iname ".DS_Store" -o -iname "Thumbs.db" -o -iname "Thumbs.db:encryptable"  \) -type f -print -exec rm -f {} \;'
alias delbak='rmbak'

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

# CAO VLSI IBP.FR
alias win='ssh-agent startx -- " -audit 4 -auth /users/cao/czo/.Xauthority"'
alias xe='gnuclient -q'
alias xroot='xv -root +noresetroot -quit'
alias xv='\xv -perfect -8'
alias xload='\xload -hl red'
alias key='perl -MCrypt::SKey -e key'
alias vieux_ccvs='export CVSROOT=lagavulin:/home/czo/cvsroot ; export CVS_RSH=~/sshc'
alias vieux_acvs='export CVSROOT=/users/outil/alliance/cvsroot'

alias imprime='a2ps -2 -s2'
alias imprimeman='a2ps -2 -s2 -man'
alias imprimescript='enscript --color -j --fancy-header=edd -E -r -2'

alias xmbk='eval $(\xmbk -c 2>/dev/null)'
alias mbk='set | grep "MBK\|RDS\|ELP" | sort'

alias ff='find . -name'
alias ffl='find . -type l -printf "ln -s %l %p\n"'
alias ffi='find . -iname'

alias sun='export TERM=sun-cmd ; echo TERM=$TERM'
alias vt100='export TERM=vt100 ; echo TERM=$TERM'
alias tek='export TERM=tek4112 ; echo TERM=$TERM'
alias xte='export TERM=xterm ; echo TERM=$TERM'
alias xts='export TERM=screen ; echo TERM=$TERM'
alias xts16='export TERM=screen-16color ; echo TERM=$TERM'
alias xts256='export TERM=screen-256color ; echo TERM=$TERM'
alias xtc='export TERM=xterm-color ; echo TERM=$TERM'
alias xtc16='export TERM=xterm-16color ; echo TERM=$TERM'
alias xtc256='export TERM=xterm-256color ; echo TERM=$TERM'

alias fing='finger | sort | uniq -w 15'
alias debug='zsh -v -x -c'

# GEOMAGNET
alias matlab='/users/soft/matlab/R2012A32x64/bin/matlab'
alias matlab-console='/users/soft/matlab/R2012A32x64/bin/matlab -nodisplay -nodesktop -nosplash'
alias ifort32='. /users/soft/intel/Compiler/11.1/059/bin/ifortvars.sh ia32'
alias ifort64='. /users/soft/intel/Compiler/11.1/059/bin/ifortvars.sh intel64'

alias bosedemerde='ssh root@localhost /home/czo/local/Linux/bin/usbresetv2 6 5'
alias sshlaga='ssh -p30022 lartha'
alias sshaberlour='ssh -p40022 lartha'
alias sshgp-vm110='ssh -p40023 lartha'
alias sshvoyelle='ssh -p40024 lartha'

# OTHER
ncd() {
    $HOME/local/$PLATFORM/bin/ncd $*
    E=$?
    if [ $E -eq 0 ]; then
        cd "$(cat "$HOME/.ncd_sdir" 2>/dev/null)"
    fi
    return $E
}

#alias ccd=ncd

mccd() {
    MC_USER=$(id | sed 's/[^(]*(//;s/).*//' 2>/dev/null)
    MC_PWD_FILE="${TMPDIR}/mc-$MC_USER/mc.pwd.$$"
    /usr/bin/mc -P "$MC_PWD_FILE" "$@"

    if test -r "$MC_PWD_FILE"; then
        MC_PWD="$(cat "$MC_PWD_FILE" 2>/dev/null)"
        if test -n "$MC_PWD" && test -d "$MC_PWD"; then
            cd "$MC_PWD"
        fi
        unset MC_PWD
    fi

    rm -f "$MC_PWD_FILE"
    unset MC_PWD_FILE
}

#alias mc=mccd

conf() {
    echo "This machine is a $(uname -a 2>/dev/null)"
    echo ""
    echo "Settings :"
    echo "    PLATFORM     = $PLATFORM"
    echo "    PRINTER      = $PRINTER"
    echo "    CVSROOT      = $CVSROOT"
    echo "    DISPLAY      = $DISPLAY"
    echo "    KDEDIR       = $KDEDIR"
    echo "    LIMIT        = $(ulimit 2>/dev/null)"
    echo ""
}

ts() { find . -type f -exec grep -l $* {} \;; }
tss() { find . -type f -print -exec grep -n $* {} \;; }
tsch() { find . \( -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.h" \) -type f -print -exec grep -n $* {} \;; }
gc() { grep $1 *.c; }
tsc() { find . -name "*.c" -type f -print -exec grep -n $* {} \;; }
tsh() { find . -name "*.h" -type f -print -exec grep -n $* {} \;; }


listext() { perl -e 'use File::Find (); File::Find::find(\&wanted, "."); sub wanted { if ((-f $_)) { $ext=$File::Find::name; $ext=~s,^.*\.,,; $list{$ext}++; } } foreach $key (sort {$list{$a} <=> $list{$b}} keys %list) { printf "$key : $list{$key}\n"; }'; }
alias mountlist='P="mount | grep -v \" /sys\| /run\| /net\| /snap\| /proc\| /dev\""; echo -e "Runing: $P\n"; eval "$P"'
alias rsyncsys='echo "mount --bind / /mnt/rootfs ; puis faire rsyncfull avec/sans -x..."'
alias rsyncfull='rsync --numeric-ids -S -H  --delete -av'
alias rsyncfat='rsync --no-p --no-g --modify-window=1 --delete -av'

alias curl_config_fast_copy='curl -fsSL https://git.io/JU6cm | sh'
alias curl_config_fast_ssh='curl -fsSL https://git.io/JU6c2 | sh'
alias wget_config_fast_all='wget -qO- http://git.io/JkHdk | sh'

acrypt() { echo $1; }
xcrypt() { perl -e 'print unpack"H*",$ARGV[0]' $1; }
xdecrypt() { perl -e 'print pack"H*",$ARGV[0]' $1; }
sri() { a=$(curl -s "$1" | openssl dgst -sha384 -binary | openssl enc -base64 -A) ; print "integrity=\"sha384-$a\" crossorigin=\"anonymous\""; }
sri2() { a=$(shasum -b -a 384 "$1" | awk '{ print $1 }' | xxd -r -p | base64) ; print "integrity=\"sha384-$a\" crossorigin=\"anonymous\""; }

cvsdiff() { F=$1 ; cvs diff $(cvs log $F | grep "^revision" | sed -e "s/^revision/-r/" -e 1q) $F; }
cvsadddir() { find $1 -type d \! -name CVS -exec cvs add '{}' \; && find $1 \( -type d -name CVS -prune \) -o \( -type f -exec cvs add '{}' \; \); }

alias cvu='cd ~/etc ; cvs up ; cd -'
alias cvd='cd ~/etc ; cvs diff ; cd -'
alias cvc='cd ~/etc ; cvs ci -mok ; cd -'

alias gitl='git pull'
alias gits='git status'
alias gitd='git diff'
alias gitf='git fetch; git diff master origin/master'
alias gita='git add .'
alias gitc='git commit -mok -a'
alias gitp='git push'

alias wgetr='wget -m -np -k -r'
alias wgetp='wget -m -l 1 --no-parent -k'

alias whatsappjpg='mogrify -resize 1918800@ -quality 75 *.jpg'

# vieux truc 'chmod -R 755 . ; find . -type f -print0 | xargs -0 chmod 644'
alias chmodr='chmod -R a-st,u+rwX,g+rX-w,o+rX-w .'
alias chmodg='chmod -R a-st,u+rwX,g+rwX,o+rX-w .'

alias tara='\tar -czf'
alias tarx='\tar -xf'
#alias tarxiso='cmake -E tar xf'
#alias tarxiso='bsdtar -xf'
tarxiso() { [ -f $1 ] && { \mkdir -p "${1%%.iso}" ; cd "${1%%.iso}" ; cmake -E tar xf ../$1; } || echo "$1 doesn't exist..."; }

v() { set | grep -ai $1; }

alias asu='su --preserve-environment -c "LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib exec /data/data/com.termux/files/usr/bin/bash" --login'

# ubuntu
ww() { uname -a; uptime; \ps --no-header -eo uid,user | sort -u | perl -ne 'BEGIN { $AutoReboot=0;$LoggedOnUsers=0;$RebootRequired=0;} @F=split (/\s+/) ; if ($F[1] > 1000 ) {$LoggedOnUsers++; print "$F[2] ($F[1])\n" } ; END { if ( -f "/var/run/reboot-required" ) { $RebootRequired=1 ;} ; print "RebootRequired=$RebootRequired\n" ; print "LoggedOnUsers=$LoggedOnUsers\n" ; if ( ! $LoggedOnUsers && $RebootRequired) {$AutoReboot=1;} print "AutoReboot=$AutoReboot\n" ; exit $AutoReboot }'; }

# debian
alias AU='aptitude update && aptitude upgrade &&  aptitude clean'
alias AI='aptitude install'
alias AP='aptitude purge'
alias AS='aptitude search'

# redhat
alias YU='yum update'
alias YI='yum install'
alias YP='yum remove'
alias YS='yum search'

# suse
alias ZU='zypper update'
alias ZI='zypper install'
alias ZP='zypper remove'
alias ZS='zypper search'

# archlinux
alias MU='pacman -Syu'
alias MI='pacman -S'
alias MP='pacman -Rs'
alias MS='pacman -Ss'

# freebsd
alias PU='pkg upgrade'
alias PI='pkg install'
alias PP='pkg remove'
alias PS='pkg search'

# OOTHER
alias mytree='tree -adn | grep -v CVS'
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias batcycle='cat /sys/class/power_supply/BAT0/cycle_count'
alias pxe='kvm -m 1024 -device e1000,netdev=net0,mac=08:11:27:B8:F8:C8 -netdev tap,id=net0'
alias qma='qm create --memory 1024 --numa 0 --sockets 1 --cores 1 -ostype l26 --net0 virtio,bridge=vmbr0,firewall=1 --ide2 none,media=cdrom --scsihw virtio-scsi-pci --scsi0 local-vm:32,format=qcow2 --name test6000 6000'
ssht() { ssh -t $@ 'tmux attach -d || tmux new'; }
alias sshtm='tmate -S ${TMPDIR}/tmate.sock new-session -d ; tmate -S ${TMPDIR}/tmate.sock wait tmate-ready ; tmate -S ${TMPDIR}/tmate.sock display -p "#{tmate_web}%n#{tmate_ssh}"'
alias color16='for i in $(seq 0 15) ; do printf "\x1b[38;5;${i}mcolour${i}\n"; done'
alias 16color='for i in $(seq 0 7); do printf "\x1b[48;5;${i}m  "; done; printf "\x1b[0m\n"; for i in $(seq 8 15); do printf "\x1b[48;5;${i}m  "; done; printf "\x1b[0m\n";'
alias color256='for i in $(seq 0 255) ; do printf "\x1b[38;5;${i}mcolour${i}\n"; done'
alias ipl='echo $(wget -q -O- http://czo.free.fr/myipa.php)'
alias ipa='ip a | grep "inet "'
alias ifa='ifconfig | grep "inet "'
alias czomac='openssl rand -hex 2 | sed "s/\(..\)\(..\)/00:67:90:79:\1:\2/" | tr "[A-F]" "[a-f]"'
alias kfm='setxkbmap fr mac'
alias console_color='/bin/echo -e "\e]P0282828\e]P1cc241d\e]P298971a\e]P3d79921\e]P4458588\e]P5b16286\e]P6689d6a\e]P7c9b788\e]P84a4239\e]P9fb4934\e]PAb8bb26\e]PBfabd2f\e]PC83a598\e]PDd3869b\e]PE8ec07c\e]PFfbf1c7" ; clear'
alias console_color_cursor='/bin/echo -ne "\e]12;#98971a\a"'
alias tmuxa='tmux attach -d || tmux new'
alias screena='screen -d -R'
alias edl='export DISPLAY=localhost:0'

alias mail_test_root='date | mail -s "CZO, from $USER@$HOSTNAME, $(date +%Y-%m-%d\ %H:%M), do not reply" root'
alias debconf_after_install='F=preseed_$(date +%Y-%m-%d)_$$.txt; debconf-get-selections --installer > $F ; debconf-get-selections >> $F'

alias pkg_inst_debian="aptitude search '~i !~M' -F %p | sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_inst_redhat="rpm -qa --qf '%{NAME}\n' | sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"
alias pkg_inst_arch="pacman -Qe | awk '{print \$1}' | sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"

alias ssha='eval $(ssh-agent); ssh-add; echo "\nTo add another identity:\nssh-add ~/.ssh/id_rsa_czo@bunnahabhain"'

##======= Completions ================================================##

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

# echo -n "DEBUG T2:"; date
if [ -n "$BASH_VERSION" ]; then
    #linux
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
    #freebsd
    if [ -f /usr/local/share/bash-completion/bash_completion.sh ]; then
        . /usr/local/share/bash-completion/bash_completion.sh
    fi
fi

# echo -n "DEBUG T3:"; date

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

export PROMPT_COMMAND="precmd"
#run once for non bash shells
precmd

# like zsh preexec : it works in bash 5 !!!
if [ -n "$BASH_VERSION" ]; then
    PS0='$(title "$(history 1  2>/dev/null | sed "s/^ *[0-9]\+ \+//" 2>/dev/null) (${USER}@${HOSTNAME})")'
fi

#HOSTNAME=czophone
#USER=root

USER_HASH=$( echo -n "AA$USER"     | cksum | cut -d" " -f1 )
HOST_HASH=$( echo -n "JC$HOSTNAME" | cksum | cut -d" " -f1 )

USER_PROMPT_COLOR=$(( ( ( $USER_HASH + 2) % 6 ) + 1 ))
# export for screen
export HOST_PROMPT_COLOR=$(( ( ( $HOST_HASH + 1 ) % 6 ) + 1 ))
export HOST_PROMPT_SIZE=%-0$(( $( echo "$HOSTNAME" | wc -c ) + 17 ))=

BVERS=$(echo '$Id: .bashrc,v 1.288 2021/03/16 14:16:46 czo Exp $' | sed -e 's/^.*,v 1.//' -e 's/ .*$//' 2>/dev/null)
SHELLNAME=$(echo $0 | sed -e 's,.*/,,' -e 's,^-,,' 2>/dev/null)

if [ -n "$BASH_VERSION" ]; then
    PS1=$'\[\e[m\]\n\[\e[0;97m\][${PLATFORM}/${SHELLNAME}] - \D{.%Y%m%d_%Hh%M} - ${TERM}:pts/\l:sh${SHLVL} - \[\e[0;9$(E=$?; if [ $E -eq 0 ]; then echo 7; else echo 1; fi; exit $E 2>/dev/null)m\][$?]\[\e[m\]\n\[\e[0;9${USER_PROMPT_COLOR}m\]${USER}\[\e[0;97m\]@\[\e[0;9${HOST_PROMPT_COLOR}m\]${HOSTNAME}\[\e[0;97m\]:\[\e[0;96m\]$PWD\[\e[m\]\n\[\e[0;97m\]>>\[\e[m\] '
else
    PS1=$'\e[m\n\e[0;97m[${PLATFORM}/${SHELLNAME}] - $(E=$?; date +.%Y%m%d_%Hh%M; exit $E) - ${TERM}:pts/\l:sh${SHLVL} - \e[0;9$(E=$?; if [ $E -eq 0 ]; then echo 7; else echo 1; fi; exit $E 2>/dev/null)m[$?]\e[m\n\e[0;9${USER_PROMPT_COLOR}m${USER}\e[0;97m@\e[0;9${HOST_PROMPT_COLOR}m${HOSTNAME}\e[0;97m:\e[0;96m$PWD\e[m\n\e[0;97m>>\e[m '
fi
# old sh/ash/dash .shrc .shinit ($' works in sh android but not in sh freebsd)
#PS1="${USER}@${HOSTNAME} >> "

# limit -s
# ulimit unlimited
stty -ixon

if [ $(id -u) -eq 0 ]; then
    umask 002
else
    umask 022
fi

#FIXME: typeset -U like in zsh
# we must put /bin at the end because if not it's ./
export PATH=$(echo $PATH | awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}' 2>/dev/null)"/bin"

#export LC_ALL=C
#mksquashfs . ../00-czo.sb -comp xz -Xbcj x86
#echo 30 > /sys/class/leds/smc\:\:kbd_backlight/brightness
#echo 30 > /sys/class/backlight/acpi_video0/brightness

#echo -n "DEBUG T4:"; date

# EOF

