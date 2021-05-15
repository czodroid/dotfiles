#             ,,,
#            (o o)
####=====oOO--(_)--OOO=========================================####
#
# Filename: .cshrc
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: April 1993
# Last Modified: samedi 15 mai 2021, 21:13
# Description:
#
#       ~/.cshrc config file for csh or tcsh
#       it was really a good trick to update my .cshrc
#       with my .bashrc 20 years later!!!
#       but be careful, I dont use it...
#
# $Id: .cshrc,v 1.9 2021/05/15 19:14:43 czo Exp $
#



##======= Settings ================================================##
# en test !
#    exit 0

# If not running interactively, don't do anything
if (! $?prompt) then
    exit 0
endif

set histfile = ~/.history
set histdup  = erase
set history  = ( 10000 "%h %D/%W/%Y %P\t%R\n" )
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
        test -f $i
        if ($status == 0) then
            source $i
        endif
    end
    unset i nonomatch
endif


##======= Key bindings ============================================##
if ($?tcsh) then

# emacs key bindings
bindkey -e

# Czo defines
bindkey -cb C-xr   "source ~/.cshrc"
bindkey -cb C-xx   "bindkey"

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

bindkey -b C-p     history-search-backward
bindkey -b C-n     history-search-forward

bindkey "\e[3~"    delete-char
bindkey -b C-h     backward-delete-char

bindkey "\e[3;3~"  delete-word
bindkey -b M-h     backward-delete-word

bindkey "\e\e"     kill-whole-line
#bindkey "\em"      copy-prev-shell-word

endif


##======= Completions =============================================##

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


##======= Platform ================================================##

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

case FreeBSD:
    setenv PLATFORM FreeBSD
    breaksw

case OpenBSD:
    setenv PLATFORM OpenBSD
    breaksw

case NetBSD:
    setenv PLATFORM NetBSD
    breaksw

case HP-UX:
    setenv PLATFORM HPUX
    breaksw

case OSF1:
    setenv PLATFORM OSF
    breaksw

case CYGWIN:
    setenv PLATFORM Cygwin
    breaksw

case Darwin:
    setenv PLATFORM Darwin
    breaksw

default:
    setenv PLATFORM Unknown
    breaksw

endsw

##======= Paths ===================================================##

# Super big path pour Linux, FreeBSD, SunOS, Solaris
# WARNING : tcsh 6.07.02 : Words can be no longer than 1024 characters.

setenv PATH /system/bin:/system/xbin:/users/project/swarm/data/tools/IpgpSoftwareTools:/users/project/swarm/data/tools/CommonSoftwareTools:$HOME/bin:$HOME/.local/bin:$HOME/local/${PLATFORM}/bin:$HOME/etc/shell:/usr/local/bin:/usr/pkg/bin:/usr/local/ssh/bin:/usr/local/adm:/usr/local/etc:/usr/local/games:/usr/local/sbin:/sbin:/bin:/usr/bin:/usr/5bin:/usr/X11/bin:/usr/X11R6/bin:/usr/X11R5/bin:/usr/andrew/bin:/usr/bin/X11:/usr/bin/games:/usr/ccs/bin:/usr/dt/bin:/usr/etc:/usr/games:/usr/lang/bin:/usr/lib:/usr/lib/teTeX/bin:/usr/libexec:/usr/mail/bin:/usr/oasys/bin:/usr/openwin/bin:/usr/sadm/bin:/usr/sbin:/usr/ucb:/usr/ucb/bin:/usr/share/bin:/usr/snadm/bin:/usr/vmsys/bin:/usr/xpg4/bin:/opt/bin:/usr/lib/gmt/bin:$PATH


##======= Environment Variables ======================================##

if ( ! $?HOSTNAME ) setenv HOSTNAME `uname -n | sed 's/\..*//'`
if ( ! $?USER )     setenv USER     `id -nu`

if ($?tcsh) then
setenv LS_COLORS 'no=00:fi=00:di=94:ln=96:pi=30;104:so=37;45:do=30;105:bd=30;42:cd=30;102:or=31;107:su=37;41:sg=30;43:tw=37;44:ow=30;44:st=30;46:ex=97:*.7z=91:*.ace=91:*.alz=91:*.arc=91:*.arj=91:*.bz2=91:*.bz=91:*.cab=91:*.cpio=91:*.deb=91:*.dwm=91:*.dz=91:*.ear=91:*.esd=91:*.gz=91:*.jar=91:*.lha=91:*.lrz=91:*.lz4=91:*.lz=91:*.lzh=91:*.lzma=91:*.lzo=91:*.rar=91:*.rpm=91:*.rz=91:*.sar=91:*.swm=91:*.t7z=91:*.tar=91:*.taz=91:*.tbz2=91:*.tbz=91:*.tgz=91:*.tlz=91:*.txz=91:*.tz=91:*.tzo=91:*.tzst=91:*.war=91:*.wim=91:*.xz=91:*.z=91:*.Z=91:*.zip=91:*.zoo=91:*.zst=91:*.bmp=95:*.cgm=95:*.emf=95:*.flc=95:*.fli=95:*.gif=95:*.icns=95:*.ico=95:*.jpeg=95:*.jpg=95:*.mng=95:*.pbm=95:*.pcx=95:*.pgm=95:*.png=95:*.ppm=95:*.svg=95:*.svgz=95:*.tga=95:*.tif=95:*.tiff=95:*.webp=95:*.xbm=95:*.xcf=95:*.xpm=95:*.xwd=95:*.asf=35:*.avi=35:*.flv=35:*.m2v=35:*.m4v=35:*.mjpeg=35:*.mjpg=35:*.mkv=35:*.mov=35:*.mp4=35:*.mp4v=35:*.mpeg=35:*.mpg=35:*.nuv=35:*.ogm=35:*.ogv=35:*.ogx=35:*.qt=35:*.rm=35:*.rmvb=35:*.vob=35:*.webm=35:*.wmv=35:*.aac=36:*.au=36:*.flac=36:*.m4a=36:*.mid=36:*.midi=36:*.mka=36:*.mp3=36:*.mpc=36:*.oga=36:*.ogg=36:*.opus=36:*.ra=36:*.spx=36:*.wav=36:*.xspf=36:*.doc=92:*.docx=92:*.odp=92:*.ods=92:*.odt=92:*.pdf=92:*.ppt=92:*.pptx=92:*.xls=92:*.xlsx=92:*.bat=93:*.c=93:*.C=93:*.cc=93:*.cl=93:*.cmd=93:*.coffee=93:*.cpp=93:*.csh=93:*.css=93:*.csv=93:*.cxx=93:*.el=93:*.erb=93:*.f90=93:*.f=93:*.F=93:*.go=93:*.h=93:*.haml=93:*.hpp=93:*.hs=93:*.htm=93:*.html=93:*.java=93:*.js=93:*.l=93:*.latex=93:*.less=93:*.log=93:*.man=93:*.md=93:*.n=93:*.objc=93:*.p=93:*.php=93:*.pl=93:*.pm=93:*.pod=93:*.py=93:*.rb=93:*.rdf=93:*.sass=93:*.scss=93:*.sh=93:*.shtml=93:*.sql=93:*.sv=93:*.svh=93:*.tex=93:*.txt=93:*.v=93:*.vh=93:*.vhd=93:*.vim=93:*.xml=93:*.zsh=93:'
endif

setenv LESS     '-i -j5 -PLine\:%lb/%L (%pb\%) ?f%f:Standard input. [%i/%m] %B bytes'
setenv PAGER    less
setenv PERLDOC_PAGER 'less -R'
setenv PGPPATH ~/.pgp
setenv EDITOR vim
setenv CVSEDITOR vim
setenv RSYNC_RSH ssh
setenv CVSROOT ananas:/tank/data/czo/CzoDoc/cvsroot
setenv PRINTER BW_Pigeonnier_ananas
setenv HTML_TIDY $HOME/.tidyrc


##======= Aliases & NO-Functions ==================================##

unalias *

alias st    'source ~/.cshrc'
alias hload 'history -L -M'
alias hsave 'history -S -M'
alias hi    'history'
alias hgrep 'history | grep'

alias t     'where'
alias v     'set | grep -ai \!*'

switch ($PLATFORM)
    case Linux*:
        alias cp    '\cp -i'
        alias mv    '\mv -i'
        alias grep  '\grep --color'
        alias pgrep '\pgrep -af'
        alias ps    '\ps -eaf'
        alias ls    '\ls --time-style=long-iso --color=auto -a'
        breaksw

    FreeBSD)
        alias grep '\grep --color'
        alias ps   '\ps -Awww'
        alias ls   '\ls -G -a'
        breaksw

    NetBSD | OpenBSD)
        alias ps '\ps -Awww'
        alias ls '\ls -a'
        breaksw

    Darwin)
        setenv DISPLAY :0
        setenv JAVA_HOME /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
        alias grep '\grep --color'
        alias ps   '\ps -Awww'
        alias ls   '\ls -G -a'
        breaksw

    SunOS | Solaris)
        alias ps '\ps -ef'
        alias ls '\ls -a'
        breaksw

    Cygwin)
        setenv DISPLAY localhost:0
        alias cp   '\cp -i'
        alias mv   '\mv -i'
        alias grep '\grep --color'
        alias ps   '\ps -aflW'
        alias ls   '\ls --time-style=long-iso --color=auto -a'
        breaksw
endsw

alias rule 'echo "....|....1....|....2....|....3....|....4....|....5....|....6....|....7....|....8....|....9" '

#alias ls '\ls --time-style=long-iso --color=auto -a'
alias ll        'ls -l'
alias lh        'ls -lh'
alias l         'ls -alrt'

alias llt       'find . -type f -printf "%TF_%TR %5m %10s %p\n" | sort -n'
alias lls       'find . -type f -printf "%s %TF_%TR %5m %p\n" | sort -n'
alias llexe     'find . -type f -perm +1 -print'
alias md        '\mkdir -p'
alias mdcd      '\mkdir -p "\!*" ; cd "\!*"'
alias ff        'find . -iname "*\!**"'
alias ff_cs     'find . -name "*\!**"'

alias rmf       'rm -fr'
alias rmemptyf  'find . -empty -type f -print -exec rm {} \;'
alias rmemptyd  'find . -empty -type d -print -exec rm -fr {} \;'
alias rmbak     'find . \( -iname "core" -o -iname "#*#" -o -iname "*.bak" -o -iname ".*.bak" -o -iname "*.swp" -o -iname "*~" -o -iname ".*~" \) -type f -print -exec rm -f {} \;'
alias rm._      'find . \( -iname "._*" -o -iname ".DS_Store" -o -iname "Thumbs.db" -o -iname "Thumbs.db:encryptable"  \) -type f -print -exec rm -f {} \;'

alias more less

#alias vim vimx
alias vi vim
alias nvim      'nvim -u ~/.vimrc'
alias ne        'emacs -nw'

alias psg       'ps | grep -i \!* | sort -r -k 3 | grep -v "grep \\!*\|sort -r -k 3"'

alias wgetr     'wget -m -np -k -r'
alias wgetp     'wget -m -np -k -l1'

alias ncd       '\ncd \!* ; if $status == 0 cd "`cat $HOME/.ncd_sdir`"'

#alias vt100     'set term=vt100 ; echo term=$term'

## CAO VLSI IBP.FR

alias sun    'set term=sun-cmd ; echo term=$term'
alias vt100  'set term=vt100 ; echo term=$term'
alias xte    'set term=xterm ; echo term=$term'
alias xts    'set term=screen ; echo term=$term'
alias xtc    'set term=xterm-color ; echo term=$term'
alias xtc256 'set term=xterm-256color ; echo term=$term'


## NEW

alias mountlist 'P="mount | grep -v \" /sys\| /run\| /net\| /snap\| /proc\| /dev\""; echo -e "Runing: $P\n"; eval "$P";'
alias rsyncsys  'echo "mount --bind / /mnt/rootfs ; puis faire rsyncfull avec/sans -x..."'
alias rsyncfull 'rsync --numeric-ids -S -H --delete -av'
alias rsyncfat  'rsync --no-p --no-g --modify-window=1 --delete -av'

alias curl_config_fast_copy 'curl -fsSL https://git.io/JU6cm | sh'
alias curl_config_fast_ssh  'curl -fsSL https://git.io/JU6c2 | sh'
alias wget_config_fast_all  'wget --no-check-certificate -qO- http://git.io/JkHdk | sh'

alias passwd_md5    'openssl passwd -1 '
alias passwd_sha512 'openssl passwd -6 '

alias cvu 'cd ~/etc ; cvs up ; cd -'
alias cvd 'cd ~/etc ; cvs diff ; cd -'
alias cvc 'cd ~/etc ; cvs ci -mok ; cd -'

alias gitl 'git pull'
alias gits 'git status'
alias gitd 'git diff'
alias gitf 'git fetch; git diff master origin/master'
alias gita 'git add .'
alias gitc 'git commit -mok -a'
alias gitp 'git push'

alias whatsappjpg 'mogrify -resize 1918800@ -quality 75 *.jpg'

# vieux truc 'chmod -R 755 . ; find . -type f -print0 | xargs -0 chmod 644'
alias chmodr 'chmod -R a-st,u+rwX,g+rX-w,o+rX-w .'
alias chmodg 'chmod -R a-st,u+rwX,g+rwX,o+rX-w .'

alias tara '\tar -czf'
alias tarx '\tar -xf'
alias tarxiso 'cmake -E tar xf'

# debian, ubuntu
alias AU 'aptitude update && aptitude upgrade &&  aptitude clean'
alias AI 'aptitude install'
alias AP 'aptitude purge'
alias AS 'aptitude search'

# archlinux
alias PU 'pacman -Syu'
alias PI 'pacman -S'
alias PP 'pacman -Rs'
alias PS 'pacman -Ss'

# redhat: yum, dnf
# suse: zypper
# freebsd: pkg
# netbsd: pkgin
# update, install, remove, search

# OOTHER
alias mytree 'tree -adn | grep -v CVS'
alias bat 'upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias batcycle 'cat /sys/class/power_supply/BAT0/cycle_count'
alias pxe 'kvm -m 1024 -device e1000,netdev=net0,mac=08:11:27:B8:F8:C8 -netdev tap,id=net0'
alias qma 'qm create --memory 1024 --numa 0 --sockets 1 --cores 1 -ostype l26 --net0 virtio,bridge=vmbr0,firewall=1 --ide2 none,media=cdrom --scsihw virtio-scsi-pci --scsi0 local-vm:32,format=qcow2 --name test6000 6000'
alias czomac 'openssl rand -hex 2 | sed "s/\(..\)\(..\)/00:67:90:79:\1:\2/" | tr "[A-F]" "[a-f]"'
alias ssh_tmux "ssh -t \!* 'tmux attach -d || tmux new'"
alias tmate_ssh 'tmate -S ${TMPDIR}/tmate.sock new-session -d ; tmate -S ${TMPDIR}/tmate.sock wait tmate-ready ; tmate -S ${TMPDIR}/tmate.sock display -p "#{tmate_web}%n#{tmate_ssh}"'

alias color16 'foreach i ( `seq 0 15` )\
printf "\x1b[38;5;${i}mcolour${i}\n"\
end'
alias 16color '\
    foreach i ( `seq 0 7` )\
        printf "\x1b[48;5;${i}m  "\
    end\
    printf "\x1b[0m\n"\
    foreach i ( `seq 8 15` )\
        printf "\x1b[48;5;${i}m  "\
    end\
    printf "\x1b[0m\n\n"'
alias color256 'foreach i ( `seq 0 255` )\
    printf "\x1b[38;5;${i}mcolour${i}\n"\
    end'
alias console_color '/bin/echo -e "\e]P0282828\e]P1cc241d\e]P298971a\e]P3d79921\e]P4458588\e]P5b16286\e]P6689d6a\e]P7c9b788\e]P84a4239\e]P9fb4934\e]PAb8bb26\e]PBfabd2f\e]PC83a598\e]PDd3869b\e]PE8ec07c\e]PFfbf1c7" ; clear'
alias console_color_cursor '/bin/echo -ne "\e]12;#98971a\a"'

alias ipl 'echo `wget -q -O- http://czo.free.fr/myipa.php`'
alias ipa 'ip a | grep "inet "'
alias ifa 'ifconfig | grep "inet "'
alias kfm 'setxkbmap fr mac'
alias tmuxa 'tmux attach -d || tmux new'
alias screena 'screen -d -R'
alias edl 'export DISPLAY=localhost:0'

alias mail_test_root 'date | mail -s "CZO, from $USER@$HOSTNAME, `date +%Y-%m-%d\ %H:%M`, do not reply" root'
alias debconf_after_install 'F=preseed_`date +%Y-%m-%d`_$$.txt; debconf-get-selections --installer > $F ; debconf-get-selections >> $F'

# exit 42
# alias pkg_inst_debian "aptitude search '~i !~M' -F %p | sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"
# alias pkg_inst_redhat "rpm -qa --qf '%{NAME}\n' | sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"
# alias pkg_inst_arch "pacman -Qe | awk '{print \$1}' | sort > pkg_inst_${HOSTNAME}_$(date +%Y%m%d).txt"

alias ssha 'eval `ssh-agent`; ssh-add; echo "\nTo add another identity:\nssh-add ~/.ssh/id_rsa_czo@bunnahabhain"'

# fileencoding
# iconv -t utf8 -f iso88591 1rjm_ctemp -o 1rjm_ctemp
alias utf8_redode_this_directory "file -i * | grep iso-8859 | sed 's/:.*//' | xargs recode -t LATIN1..UTF-8"



##======= Main ======================================================##

alias precmd 'if (($term =~ xterm*)) echo -n "]0;${SHELLNAME} ${PWD} (${USER}@${HOST})"> /dev/tty ;  echo "[00m" '

set MYTTY     = `tty | sed s,/dev/,,`

if ($?tcsh) then
    set SHELLNAME = `echo $0 | sed -e 's,.*/,,' -e 's,^-,,'`
    set USER_HASH = `echo -n "AA$USER"     | cksum | awk '{ print $1 }'`
    set HOST_HASH = `echo -n "JC$HOSTNAME" | cksum | awk '{ print $1 }'`
    @ calc = ( ( ( $USER_HASH + 2 ) % 6 ) + 1 )
    set USER_PROMPT_COLOR = $calc
    # export for screen
    @ calc = ( ( ( $HOST_HASH + 1 ) % 6 ) + 1 )
    setenv HOST_PROMPT_COLOR $calc
    @ calc = ( ( `echo "$HOSTNAME" | wc -c` + 17 ) )
    setenv HOST_PROMPT_SIZE "%-0$calc="

    set prompt = "%{^[[0;97m%}[${PLATFORM}/${SHELLNAME}] - `date +.%Y%m%d_%Hh%M` - ${TERM}:${MYTTY}:sh${SHLVL} - [$status]\n%{^[[0;9${USER_PROMPT_COLOR}m%}${USER}%{^[[0;97m%}@%{^[[0;9${HOST_PROMPT_COLOR}m%}${HOSTNAME}%{^[[0;97m%}:%{^[[0;94m%}%/\n%{^[[0;97m%}>>%{^[[m%} "
else
    set prompt = "\
[${PLATFORM}/csh] - `date +.%Y%m%d_%Hh%M` - ${TERM}:${MYTTY} - [$status]\
${USER}@${HOSTNAME}:${PWD}\
>> "
endif

rehash
stty -ixon
umask 022

# EOF

