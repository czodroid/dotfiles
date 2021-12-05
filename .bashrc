#             ,,,
#            (o o)
####=====oOO--(_)--OOO==============================================####
#
# Filename: .bashrc
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: November 1998
# Last Modified: dimanche 05 décembre 2021, 16:25
# Edit Time: 96:44:14
# Description:
#         ~/.bashrc is executed by bash for non-login shells.
#         tries to mimic my .zshrc and to be 2.05 compatible
#         for old wkstations
#         rm ~/.bash_profile ~/.bash_login ~/.bash_history
#         and put instead .profile
#
# $Id: .bashrc,v 1.360 2021/12/05 17:09:59 czo Exp $

#set -v
#set -x

# RTMStart=$(date +%s%N)
# echo -n "DEBUG T1:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop

##======= Bash Settings ==============================================##

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export TMPDIR=${TMPDIR-/tmp}
#android
#export TMPDIR=${TMPDIR-/data/local/tmp}

export HISTFILE=${TMPDIR}/.sh_history

if [ -n "$BASH_VERSION" ]; then
    #busybox ash bug when defining HISTFILE...
    export HISTFILE=$HOME/.sh_history
    # olivier, repasse a zsh ...
    export HISTFILESIZE=55000
    export HISTSIZE=44000
    export HISTCONTROL=ignoreboth:erasedups
fi

export TIMEFORMAT=$'\n%3lR real    %3lU user    %3lS system    %P%%'

#BASHMISSING : REPORTTIME, complete alias, equal =foo
# removed zsh preexec implementation of REPORTTIME, see rev 1.32
#avoid overwriting history
#shopt -s histappend
#export HISTTIMEFORMAT='%F %T '
#BASHBUG history remove duplicates

if [ -n "$BASH_VERSION" ]; then
    shopt -s autocd
    shopt -s checkwinsize
    #shopt -s dotglob
    shopt -s globstar
fi


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

fi


##======= Completions ================================================##

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if [ -n "$BASH_VERSION" ]; then
    #linux, but not on idefix (debian 5)
    if [ "X${HOSTNAME}" != "Xidefix" ]; then
        if [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
    #freebsd
    if [ -f /usr/local/share/bash-completion/bash_completion.sh ]; then
        . /usr/local/share/bash-completion/bash_completion.sh
    fi
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

## config termux for android
export PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets:/system/bin:/system/xbin:/system/bin:/system/xbin:${PATH}
export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib

## config SWARM
#export PATH=/users/project/swarm/data/tools/IpgpSoftwareTools:/users/project/swarm/data/tools/CommonSoftwareTools:$PATH

# there was a time when I needed it, but I can't remember anymore...
#typeset -U MANPATH=$HOME/local/share/man:/usr/pkg/man:/usr/man:/usr/local/man:/usr/local/lib/gcc-lib/man:/usr/local/lib/perl5/man:/usr/local/lib/texmf/man:/usr/man/preformat:/usr/openwin/man:/usr/share/man:/usr/5bin/man:/usr/X11/man:/usr/X11R6/man:/usr/dt/man:/usr/lang/man:$MANPATH
#export MANPATH

# export LD_RUN_PATH=/users/soft5/gnu/bazar/archi/Linux/lib/wxgtk/lib

export PATH


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

unalias -a

alias where='type -a'
alias t='type -a'
alias a='type -a'
alias eq='type -P'

alias st='source ~/.bashrc'
alias hi='fc -l -9111000'
alias h='fc -l -9111000 | grep'

alias history_load='history -r'
alias history_save='history -w'
alias history_clear='history -c'
alias history_clear_all_log='echo > /var/log/wtmp ; echo > /var/log/lastlog ; history -c'
#to run sometimes, BUG no dup history
alias history_bash_bug='history -n; history | tac | sed "s/^ *[0-9]\+ \+//" | sed "s/\s\+$//" | perl -ne  "print if not \$x{\$_}++;" | tac > $HISTFILE ; history -c ; history -r'

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
#  aptitude upgrade = apt upgrade != apt-get upgrade
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

alias sb="$(perl -mDigest::MD5=md5_hex -e 'print qq+squeezelite -n $ARGV[0] -m + . join(qq+:+, substr(md5_hex(qq+$ARGV[0]+),0,12) =~ /(..)/g)' $HOSTNAME)"

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

PROMPT_COMMAND="precmd"
#run once for non bash shells
precmd

# like zsh preexec : it works in bash 5 !!!
if [ -n "$BASH_VERSION" ]; then
    PS0='$(title "$(history 1  2>/dev/null | sed "s/^ *[0-9]\+ \+//" 2>/dev/null) (${USER}@${HOSTNAME})")'
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

BVERS=$(echo '$Id: .bashrc,v 1.360 2021/12/05 17:09:59 czo Exp $' | sed -e 's/^.*,v 1.//' -e 's/ .*$//' 2>/dev/null)
SHELLNAME=$(echo $0 | sed -e 's,.*/,,' -e 's,^-,,' 2>/dev/null)

MYTTY=$(tty 2>/dev/null | sed s,/dev/,,)

if [ -n "$BASH_VERSION" ]; then
    PS1=$'\[\e[m\]\n\[\e[0;97m\][${PLATFORM}/${SHELLNAME}] - \D{.%Y%m%d_%Hh%M} - ${TERM}:${MYTTY}:sh${SHLVL} - \[\e[0;9$(E=$?; if [ $E -eq 0 ]; then echo 7; else echo 1; fi; exit $E 2>/dev/null)m\][$?]\[\e[m\]\n\[\e[0;9${USER_PROMPT_COLOR}m\]${USER}\[\e[0;97m\]@\[\e[0;9${HOST_PROMPT_COLOR}m\]${HOSTNAME}\[\e[0;97m\]:\[\e[0;96m\]$PWD\[\e[m\]\n\[\e[0;97m\]>>\[\e[m\] '
else
    PS1=$'\e[m\n\e[0;97m[${PLATFORM}/${SHELLNAME}] - $(E=$?; date +.%Y%m%d_%Hh%M; exit $E) - ${TERM}:${MYTTY}:sh${SHLVL} - \e[0;9$(E=$?; if [ $E -eq 0 ]; then echo 7; else echo 1; fi; exit $E 2>/dev/null)m[$?]\e[m\n\e[0;9${USER_PROMPT_COLOR}m${USER}\e[0;97m@\e[0;9${HOST_PROMPT_COLOR}m${HOSTNAME}\e[0;97m:\e[0;96m$PWD\e[m\n\e[0;97m>>\e[m '
fi
# old sh/ash/dash .shrc .shinit ($' works in sh android but not in sh freebsd)
# PS1='
# [${PLATFORM}/${SHELLNAME}] - $(date +.%Y%m%d_%Hh%M) - ${TERM}:${MYTTY}:sh${SHLVL} - [$?]
# ${USER}@${HOSTNAME}:$PWD
# >> '

# limit -s
# ulimit unlimited

# busybox has no stty on openWRT!
[ -x "$(command -v stty)" ] && stty -ixon

umask 022

#FIXME: zsh, export -U PATH
export PATH=$(echo $PATH | awk -F: '{for (i=1;i<=NF;i++) {if ( !x[$i]++ ) {if (ft++) printf(":"); printf("%s",$i); }}}')

# echo -n "DEBUG T2:"; RTMStop=$(date +%s%N); echo " $((($RTMStop-$RTMStart)/1000000))ms"; RTMStart=$RTMStop
# EOF

