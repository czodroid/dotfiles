#             ,,,
#            (o o)
####=====oOO==(_)==OOo==============================================####
#
# Filename: .cshrc
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 12 April 1993
# Last Modified: Wednesday 01 January 2025, 13:47
# $Id: .cshrc,v 1.177 2025/01/01 12:49:07 czo Exp $
# Edit Time: 32:33:39
# Description:
#
#       csh and tcsh config file
#
#       it was really a good trick to update my .cshrc
#       30 years later!!!
#       but be careful, I don't use it, and I don't know
#       if all the alias are OK...
#       keep this for fun!
#
# Copyright: (C) 1993-2025 Olivier Sirol <czo@free.fr>

##======= Csh Settings ===============================================##

# If not running interactively, don't do anything
if (! $?prompt) then
    exit 0
endif

set histfile = ~/.history
set histdup  = erase
set history  = ( 11000 "%h\t%R\n" )
set savehist = (  9000  merge )

set autorehash
set autolist = ambiguous
set highlight
unset autologout

set listflags = -AF

set time = 5
set printexitvalue
set notify
set rmstar

if (-d /etc/profile.d) then
    set nonomatch
    foreach i ( /etc/profile.d/*.csh )
        if (-f $i) then
            source $i
        endif
    end
    unset i nonomatch
endif

##======= Platform ===================================================##

switch (`uname`)
case Linux:
    switch (`uname -m`)
    case  i*86:
        setenv PLATFORM Linux_x86
        breaksw
    case x86_64:
        setenv PLATFORM Linux
        breaksw
    case mips:
        setenv PLATFORM Linux_mips
        breaksw
    case arm*:
        setenv PLATFORM Linux_arm
        breaksw
    case aarch*:
        setenv PLATFORM Linux_aarch
        breaksw
    endsw
breaksw

case SunOS:
    if ( `uname -r` =~ 5.* ) then
        setenv PLATFORM Solaris
    else
        setenv PLATFORM SunOS
    endif
    breaksw

case CYGWIN*:
    setenv PLATFORM Cygwin
    breaksw

case MINGW64*:
    setenv PLATFORM Mingw
    breaksw

# FreeBSD | OpenBSD | NetBSD | HP-UX | OSF1 | Darwin
default:
    setenv PLATFORM `uname`
    if ( "$PLATFORM" == "" ) setenv PLATFORM Unknown
    breaksw

endsw

##======= Paths ======================================================##

# Super big path pour Linux, FreeBSD, SunOS, Solaris
# WARNING : tcsh 6.07.02 : Words can be no longer than 1024 characters.
#setenv PATH $HOME/etc/shell:$HOME/.local/local/${PLATFORM}/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/pkg/bin:/usr/gnu/bin:/usr/local/ssh/bin:/usr/local/adm:/usr/local/etc:/usr/local/games:/usr/5bin:/usr/X11/bin:/usr/X11R5/bin:/usr/andrew/bin:/usr/bin/games:/usr/ccs/bin:/usr/dt/bin:/usr/etc:/usr/lang/bin:/usr/lib/teTeX/bin:/usr/libexec:/usr/mail/bin:/usr/oasys/bin:/usr/openwin/bin:/usr/sadm/bin:/usr/ucb:/usr/ucb/bin:/usr/share/bin:/usr/snadm/bin:/usr/vmsys/bin:/usr/xpg4/bin:/opt/bin:/usr/lib/gmt/bin:$PATH

setenv PATH $HOME/bin:$HOME/.local/bin:$HOME/etc/shell:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:$PATH

##======= Environment Variables ======================================##

if ( ! $?HOSTNAME ) setenv HOSTNAME `uname -n | sed 's/\..*//'`
if ( ! $?USER )     setenv USER     `id -nu`

if ($?tcsh) then
# csh: line < 1024 char
setenv LS_COLORS 'no=00:fi=00:di=94:ln=96:pi=30;104:so=37;45:do=30;105:bd=30;42:cd=30;102:or=31;107:ex=97:*.7z=91:*.bz2=91:*.bz=91:*.cpio=91:*.deb=91:*.gz=91:*.jar=91:*.rar=91:*.rpm=91:*.tar=91:*.tgz=91:*.txz=91:*.xz=91:*.z=91:*.zip=91:*.bmp=95:*.gif=95:*.heic=95:*.jpeg=95:*.jpg=95:*.mng=95:*.pbm=95:*.png=95:*.ppm=95:*.svg=95:*.svgz=95:*.tif=95:*.webp=95:*.xbm=95:*.xpm=95:*.avi=35:*.flv=35:*.mkv=35:*.mov=35:*.mp4=35:*.mpeg=35:*.mpg=35:*.ogm=35:*.webm=35:*.aac=36:*.au=36:*.flac=36:*.m4a=36:*.mp3=36:*.ogg=36:*.opus=36:*.wav=36:*.doc=92:*.docx=92:*.latex=92:*.man=92:*.md=92:*.odp=92:*.ods=92:*.odt=92:*.pdf=92:*.pod=92:*.ppt=92:*.pptx=92:*.tex=92:*.xls=92:*.xlsx=92:*.bat=93:*.c=93:*.cc=93:*.cl=93:*.cmd=93:*.cpp=93:*.csh=93:*.css=93:*.cxx=93:*.el=93:*.f90=93:*.f=93:*.go=93:*.h=93:*.hh=93:*.hpp=93:*.hs=93:*.htm=93:*.html=93:*.ino=93:*.java=93:*.js=93:*.json=93:*.l=93:*.lua=93:*.n=93:*.p=93:*.php=93:*.pl=93:*.pm=93:*.py=93:*.rb=93:*.sh=93:*.sql=93:*.sv=93:*.svh=93:*.v=93:*.vhd=93:*.vim=93:*.zsh=93'
endif

# BSD ls
setenv LSCOLORS 'ExGxfxFxHxacabxDxeae'

setenv LESS              '-i -j5 -PLine\:%lb/%L (%pb\%) ?f%f:Standard input. [%i/%m] %B bytes'
setenv HIGHLIGHT_OPTIONS '--force -s base16/gruvbox-dark-hard'
setenv PAGER             less
setenv PERLDOC           '-oterm'
setenv PERLDOC_PAGER     'less -R'
setenv SYSTEMD_PAGER     cat
setenv RSYNC_RSH         ssh
setenv EDITOR            vim
setenv CVS_RSH           ssh
setenv CVSEDITOR         vim
setenv PGPPATH           $HOME/.gnugp
setenv HTML_TIDY         $HOME/.tidyrc
setenv CVSROOT           czo@dalmorechezwam:/tank/data/czo/.cvsroot
setenv PRINTER           LaserJet

##======= Key bindings ===============================================##

if ($?tcsh) then

# emacs key bindings
bindkey -e

# Czo defines
bindkey -cb ^xr    "source ~/.cshrc"
bindkey -cb ^xx    "bindkey"

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

bindkey "\e[A"     history-search-backward
bindkey "\eOA"     history-search-backward
bindkey "\e[1;5A"  history-search-backward

bindkey "\e[B"     history-search-forward
bindkey "\eOB"     history-search-forward
bindkey "\e[1;5B"  history-search-forward

bindkey -b ^p      history-search-backward
bindkey -b ^n      history-search-forward

bindkey "\e[3~"    delete-char
bindkey -b ^h      backward-delete-char

bindkey "\e[3;3~"  delete-word
bindkey -b M-h     backward-delete-word

bindkey "\e\e"     kill-whole-line
#bindkey "\em"      copy-prev-shell-word

endif


##======= Completions ================================================##

if ($?tcsh) then
    complete alias        'p/1/a/'
    complete man          'p/*/c/'
    complete set          'p/1/s/'
    complete unset        'p/1/s/'
    complete setenv       'p/1/e/' 'n@DISPLAY@`cat $HOME/.completion_displays`@'
    complete unsetenv     'p/1/e/'
    complete ftp          'p/1/$hostnames/'
    complete kill         'p/*/`ps h | awk \{print\ \$1\}`/'
    complete finger       'c/*@/$hostnames/' 'p/1/u/@'
    complete elm          'c@=@F:$HOME/Mail/@'
    complete find         'n/-name/f/' 'n/-newer/f/' 'n/-{,n}cpio/f/' 'n/-exec/c/' 'n/-ok/c/' 'n/-user/u/' 'n/-group/g/' 'n/-fstype/(nfs 4.2)/' 'n/-type/(b c d f l p s)/' 'c/-/(name newer cpio ncpio exec ok user group fstype type atime ctime depth inum ls mtime nogroup nouser perm print prune size xdev)/' 'p/*/d/'
    complete make         'p/1/`getMakeToken`/'
    complete ncd          'p@1@`cat $HOME/.ncd_htree | gawk \{print\ \$2\} | sort | uniq`@'
    complete ccd          'p@1@`cat $HOME/.ncd_ftree | gawk \{print\ \$2\} | sort | uniq`@'
    complete cd           'p/*/d/'
    complete cvs          'p/1/`(cvs --help-commands || true ) |& sed 1d  | awk \{print\ \$1\}`/'
    complete telnet       'p@1@`cat $HOME/.completion_hosts`@'
    complete ssh          'p@1@`cat $HOME/.completion_hosts`@' 'n@-l@u@'
    complete rlogin       'p@1@`cat $HOME/.completion_hosts`@' 'n@-l@u@'
    complete rsh          'p@1@`cat $HOME/.completion_hosts`@' 'n@-l@u@'
    complete ping         'p@1@`cat $HOME/.completion_hosts`@'
    complete nsl          'p@1@`cat $HOME/.completion_hosts`@'
    complete traceroute   'p@1@`cat $HOME/.completion_hosts`@'
    complete prtraceroute 'p@1@`cat $HOME/.completion_hosts`@'
    complete ftp          'p@1@`cat $HOME/.completion_hosts`@'
    complete xhost        'p@1@`cat $HOME/.completion_hosts`@'
    complete ftp          'p@1@`cat $HOME/.completion_hosts`@'
    complete rup          'p@1@`cat $HOME/.completion_hosts`@'
    complete su           'p/*/u/'
    complete xlock        'n/-mode/`getXlockModes`/'
endif

##======= Aliases & NO-Functions =====================================##

unalias *

alias .     'source'

alias t     'where'
alias a     'where'
# alias v     'set | grep -ai \!*'

alias st    'source ~/.cshrc'
alias hi    'history'
alias h     'history | sed "s/^[ \t]*[0-9]\+[ \t]\+//" | grep'

alias history_load 'history -L -M'
alias history_hsave 'history -S -M'

switch ($PLATFORM)
    case Linux*:
        alias cp    '\cp -i'
        alias mv    '\mv -i'
        alias grep  '\grep --color'
        alias ps    '\ps -eaf'
        alias pg    '\pgrep -fia'
        alias pk    '\pkill -fie'
        alias ls    '\ls --time-style=long-iso --color=auto -a'
        breaksw

    case FreeBSD:
        alias grep  '\grep --color'
        alias ps    '\ps -Awww'
        alias pg    '\pgrep -fil'
        alias pk    '\pkill -fil'
        alias ls    '\ls -G -a'
        breaksw

    case NetBSD | OpenBSD:
        alias ps    '\ps -Awww'
        alias ls    '\ls -a'
        breaksw

    case Darwin:
        setenv DISPLAY :0
        alias grep  '\grep --color'
        alias ps    '\ps -Awww'
        alias pg    '\pgrep -fil'
        alias pk    '\pkill -fil'
        alias ls    '\ls -G -a'
        breaksw

    case SunOS | Solaris:
        alias ps    '\ps -ef'
        alias ls    '\ls -a'
        alias pg    '\pgrep -fl'
        alias pk    '\pkill -fl'
        breaksw

    case Cygwin | Mingw:
        setenv DISPLAY :0
        alias cp    '\cp -i'
        alias mv    '\mv -i'
        alias grep  '\grep --color'
        alias ps    '\ps -aflW'
        alias pg    '\pgrep -fia'
        alias pk    '\pkill -fie'
        alias ls    '\ls --time-style=long-iso --color=auto -a'
        breaksw
endsw

alias rule 'echo "....|....1....|....2....|....3....|....4....|....5....|....6....|....7....|....8....|....9" '

#alias ls '\ls --time-style=long-iso --color=auto -a'
alias ll       'ls -l'
alias lh       'ls -lh'
alias l        'ls -alrt'
alias g        'grep -sri'
alias g_cs     'grep -sr'
alias ..       'cd ..'

alias llt      'find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -printf "%TF_%TR %5m %10s %p\n" | sort -n'
alias lls      'find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -printf "%s %TF_%TR %5m %p\n" | sort -n'
alias llx      'find . -type d \( -name '.git' -o -name 'CVS' \) -prune -o -type f -perm -1 -print | sort'
alias lll      'find . -type l  -printf "%p -> %l\n"'
alias md       '\mkdir -p'
alias mdcd     '\mkdir -p "\!*" ; cd "\!*"'
alias ff       'find . -iname "*\!**"'
alias ff_cs    'find . -name "*\!**"'

alias rmf      'rm -fr'
alias rmemptyf 'find . -empty -type f -print -exec rm {} \;'
alias rmemptyd 'find . -empty -type d -print -exec rm -fr {} \;'
alias rmbak    'find . \( -iname "core" -o -iname "#*#" -o -iname "*.bak" -o -iname ".*.bak" -o -iname ".*.sw?" -o -iname "*~" -o -iname ".*~" -o -iname ".#*" -o -iname "._*" -o -iname ".DS_Store" -o -iname "Thumbs.db" -o -iname "Thumbs.db:encryptable" \) -type f -print -exec rm -f {} \;'

if (-f "$HOME/.vimrc.czo") then
    setenv VIMINIT "source $HOME/.vimrc.czo"
endif

alias more     'less'
alias ne       '\emacs -nw'

alias mc       '\mc -b -u'
#alias htop     '\htop -C'

alias psg      'ps | grep -i \!* | sort -r -k 3 | grep -v "grep \\!*\|sort -r -k 3"'

alias n        'ncd \!* ; if $status == 0 cd "`cat $HOME/.ncd_sdir`"'

alias wgetr    'wget -m -np -k -r'
alias wgetp    'wget -m -np -k -l1'

alias chmod644 'chmod -R 755 . ; find . -type f -print0 | xargs -0 chmod 644'
alias chmodr   'chmod -R a-st,u+rwX,g+rX-w,o+rX-w .'
alias chmodg   'chmod -R a-st,u+rwX,g+rwX,o+rX-w .'

alias tara     'tar -czf'
alias tarx     'tar -xf'
alias tart     'tar -tvf'
alias tarxiso  'bsdtar -xf'

alias tsu      'su - -c "cd /; /data/data/com.termux/files/usr/bin/bash --rcfile /data/data/com.termux/files/home/.bashrc"'

alias ipl      'echo `wget -q -O- http://czo.free.fr/ip.php`'
alias ipa      'ip a | grep "inet "'
alias ifa      'ifconfig | grep "inet "'

alias screena  'screen -d -R'
alias tmuxa    'tmux attach -t 0'
alias aa       'tmux attach -d || tmux new'
# resets the terminal mouse when tmux crashes
alias r        'tput rs2'


alias lsusb_tree    'lsusb -t -v'

alias mount_list    'P="mount | grep -v \" /sys\| /run\| /net\| /snap\| /proc\| /dev\""; echo "Runing: $P"; eval "$P"'
alias rsync_sys     'echo "mount --bind / /mnt/rootfs ; puis faire rsyncfull avec/sans -x..."'
alias rsync_full    'rsync --numeric-ids -S -H --delete -av'
alias rsync_fat     'rsync --no-p --no-g --modify-window=1 --delete -av -L'
alias rsync_normal  'rsync --delete -av'
alias lsblk         'lsblk -o NAME,SIZE,TYPE,LABEL,FSTYPE,MOUNTPOINT,MODEL'

alias FF            'curl -fsSL https://raw.githubusercontent.com/czodroid/dotfiles/master/config-fast-copy | sh'
alias FS            'curl -fsSL https://raw.githubusercontent.com/czodroid/dotfiles/master/config-fast-ssh | sh'
alias FW            'wget --no-check-certificate -qO- https://raw.githubusercontent.com/czodroid/dotfiles/master/config-debian-preseed | sh'

alias mail_test_root 'date | mail -s "CZO, from $USER@$HOSTNAME, `date +%Y-%m-%d\ %H:%M`, do not reply" root'

alias passwd_md5     'openssl passwd -1 '
alias passwd_sha512  'openssl passwd -6 '
alias ssha           'eval `ssh-agent -c`; ssh-add; echo; echo "To add another identity:"; echo "ssh-add ~/.ssh/id_rsa_czo@bunnahabhain"'
alias dig_lartha     'curl -sk http://lartha:/hosts.html'
alias tmate_ssh      'tmate -S ${TMPDIR}/tmate.sock new-session -d ; tmate -S ${TMPDIR}/tmate.sock wait tmate-ready ; tmate -S ${TMPDIR}/tmate.sock display -p "#{tmate_web}%n#{tmate_ssh}"'

# sed -i 173d ~/.ssh/known_hosts is working under linux,
# but on FreeBSD you must have gnu-sed, so perl is best!
alias sed_k 'perl -ni -e "print unless $. == \!*" ~/.ssh/known_hosts'
# escape quotes '
alias remove_empty_line_and_slash_and_print 'perl -n -e '\''print unless m/^\s*#|^\s*$/'\'

alias tree-cvs 'tree -adn | grep -v CVS'
alias dft      'df -hPT'

alias cvu 'cd ~/etc ; cvs up ; cd -'
alias cvd 'cd ~/etc ; cvs diff | colordiff ; cd -'
alias cvc 'cd ~/etc ; cvs ci -mupdate ; cd -'

alias gtu 'git pull'
alias gtd 'git diff'
alias gtc 'git commit -a -mupdate ; git push'
alias gts 'git status'
alias gta 'git add .'
alias gtb 'git branch'
alias gtf 'git fetch; git diff master origin/master'

# debian, ubuntu
alias AU  'aptitude update && aptitude upgrade && aptitude clean && echo `date +%Y-%m-%d` > /etc/lsb-czo-updatedate'
alias AI  'aptitude install'
alias AP  'aptitude purge'
alias AS  'aptitude search'
alias AW  'aptitude show'
alias AL  'dpkg -L'
alias AF  'dpkg -S'

# redhat, fedora
alias YU  'yum update && yum clean all && echo `date +%Y-%m-%d` > /etc/lsb-czo-updatedate'
alias YI  'yum install'
alias YP  'yum remove'
alias YS  'yum list "*\!**"'
alias YSS 'yum search'
alias YL  'rpm -ql'
alias YF  'rpm -qf'

# openwrt: opkg
alias OU  'opkg update ; opkg list --size > /tmp/opkg.list && echo ; echo "opkg list is in /tmp/opkg.list"'
alias OI  'opkg install'
alias OP  'opkg remove'
alias OS  'grep \!* /tmp/opkg.list'
alias OW  'opkg info'
alias OL  'opkg files'
alias OF  'opkg search'

# archlinux
alias PU  'pacman --noconfirm -Sy archlinux-keyring && pacman --noconfirm -Su && pacman --noconfirm -Scc && echo `date +%Y-%m-%d` > /etc/lsb-czo-updatedate'
alias PI  'pacman -Sy'
alias PP  'pacman -Rs'
alias PS  'pacman -Ss'
alias PL  'pacman -Ql'
alias PF  'pacman -Qo'

# freebsd
alias KU  'pkg update && pkg upgrade && pkg clean && echo `date +%Y-%m-%d` > /etc/lsb-czo-updatedate'

# brew macos
alias BU  'brew update && brew upgrade && brew cleanup'

# choco windows
alias CU  'choco upgrade all -y && cyg-get.bat -upgrade all'

# suse: zypper
# netbsd: pkgin

alias sun    'set term=sun-cmd ; echo term=$term'
alias vt100  'set term=vt100 ; echo term=$term'
alias xte    'set term=xterm ; echo term=$term'
alias xts    'set term=screen ; echo term=$term'
alias xtc    'set term=xterm-color ; echo term=$term'
alias xtc16  'set term=xterm-16color ; echo term=$term'
alias xtc256 'set term=xterm-256color ; echo term=$term'

alias console_color                 "printf '\e]P0282828\e]P1cc241d\e]P298971a\e]P3fe8019\e]P4458588\e]P5b16286\e]P6689d6a\e]P7c9b788\e]P84a4239\e]P9fb4934\e]PAb8bb26\e]PBfabd2f\e]PC83a598\e]PDd3869b\e]PE8ec07c\e]PFfbf1c7'; clear"
alias console_cursor_color          "printf '\e]12;#98971a\a'"
alias console_cursor_blinking_block "printf '\e[0 q'"

alias 16color '\
    foreach i ( 0 1 2 3 4 5 6 7 )\
        printf "\033[48;5;${i}m  "\
    end\
    printf "\033[0m\n"\
    foreach i ( 8 9 10 11 12 13 14 15 )\
        printf "\033[48;5;${i}m  "\
    end\
    printf "\033[0m\n\n"'

##======= Main =======================================================##

if ($?tcsh) then
    set MYTTY     = `tty | sed s,/dev/,,`
    set SHELLNAME = `echo $0 | sed -e 's,.*/,,' -e 's,^-,,'`
    # hash for colors
    set USER_PROMPT_COLOR = `printf "AA$USER" | cksum | awk '{ print ((( $1  + 2 ) % 6 ) + 1 ) }'`
    set HOST_PROMPT_COLOR = `printf "JC$HOSTNAME" | cksum | awk '{ print ((( $1  + 1 ) % 6 ) + 1 ) }'`

    alias precmd 'set E=$status ; if ($term =~ xterm*) echo -n "]0;${SHELLNAME} ${PWD} (${USER}@${HOST})"> /dev/tty ; echo "[00m" ; echo -n "[0;97m[${PLATFORM}/${SHELLNAME}] - `date +.%Y%m%d_%Hh%M` - ${TERM}:${MYTTY}:sh${SHLVL} - " ; if ($E == 0) echo "[0;97m[$E][m" ; if ($E != 0) echo "[0;91m[$E][m" ; echo "[0;9${USER_PROMPT_COLOR}m${USER}[0;97m@[0;9${HOST_PROMPT_COLOR}m${HOSTNAME}[0;97m:[0;94m${PWD}[m"'

    # set prompt = "%{^[[0;97m%}[${PLATFORM}/${SHELLNAME}] - `date +.%Y%m%d_%Hh%M` - ${TERM}:${MYTTY}:sh${SHLVL} - [$?]\n%{^[[0;9${USER_PROMPT_COLOR}m%}${USER}%{^[[0;97m%}@%{^[[0;9${HOST_PROMPT_COLOR}m%}${HOSTNAME}%{^[[0;97m%}:%{^[[0;94m%}%/\n%{^[[0;97m%}>>%{^[[m%} "
    set prompt = "%{^[[0;97m%}>>%{^[[m%} "
else
    set prompt = "${USER}@${HOSTNAME}:%/ >> "
endif

rehash
# limit -s
# ulimit unlimited
stty -ixon
umask 022

#FIXME: zsh, export -U PATH
setenv PATH `echo $PATH | awk -F: '{for (i=1;i<=NF;i++) {if ( \\!x[$i]++ ) {if (ft++) printf(":"); printf("%s",$i); }}}'`

# EOF
