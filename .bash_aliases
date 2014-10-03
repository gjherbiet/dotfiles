#-----------------------------------------------------------------------------
# Filesystem listing and navigation
#

# Listing
if ls --color > /dev/null 2>&1; then
	colorflag="--color=auto"
else
	colorflag="-G"
fi
alias ls="ls -h ${colorflag}"
alias ll="ls -lh ${colorflag}"
alias la="ls -a ${colorflag}"
alias lla="ls -lha ${colorflag}"
alias lr="ls -lh -tr ${colorflag}"
alias lar="ls -lha -tr ${colorflag}"
alias dir="lla"

# Usage
alias df='df -h'
alias du='du -h'
# Usage
function usage () {
	([ -z $1 ] && du -d 1) || du -d $1;
}

# Navigation
alias cd..='cd ..'
alias -- ..='cd ..'
alias -- ...='cd ../..'
alias -- ....='cd ../../..'
alias -- .....='cd ../../../..'
alias -- ~='cd ~'
alias -- -='cd -'
alias -- %='cd -'
alias p='pushd'
alias po='popd'

# Make and cd to a directory
function mkcd () {
	mkdir -p "$*" && cd "$*"
}
alias mcd='mkcd'
alias mkdir='mkdir -pv'
alias rmd='rm -r'
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Foolproof dangerous commands
#
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias sudo='sudo '
alias redo='sudo \!-1'
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Network-related shortcuts
#
alias gping='ping www.google.fr'

alias localip="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"

function mtu {
	ping -D -s ${1:-1472} ${2:-8.8.8.8}
}

alias randmac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'"

if which speedtest_cli > /dev/null; then
	alias speedtest="speedtest_cli  --share"
	alias speedtest_post="speedtest --server 1360"
else
	alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
fi
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Color some stuff
#
which colordiff > /dev/null && alias diff=colordiff
which colorsvn > /dev/null && alias svn=colorsvn
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Cleaning directories
#
alias texclean='find -E . -type f -regex ".*[^/]+\.(aux|bbl|blg|bmt|brf|dvi|fdb.*|idx|lof|lot|log|maf|mlf1|mlt1|mtc|mtc0|mtc1|out|pdfsync|synctex\.gz|tns|toc)$" -ls -delete'
alias pyclean='find . -type f -name "*.pyc" -ls -delete'
alias svnclean='find . -type d -name ".svn" -ls -delete'
alias dsclean="find . -type f -name '*.DS_Store' -ls -delete"
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Misc.
#

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

alias gzip='gzip -9n'
alias head='head -n 25'
alias tail='tail -n 25'
alias wget='wget -c'

#alias reload='. $HOME/.bash_profile'

alias nowtime='date "+%T"'
alias nowdate='date "+%F"'

# Add an "alert" alias for long running command
# Usage: sleep 10; alert
which notify-send > /dev/null && 
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Generate random passwords
function genpasswd () {
	if [ -z $1 ]; then pwlength=14; else pwlength=$1; fi
	if [ -z $2 ]; then pwnb=1; else pwnb=$2; fi
	for i in `seq 1 $pwnb`; do
		tr -dc "A-Za-z0-9_&@#()[]{}+-=/\\\|.\!?,;*@#&$%<>" < /dev/urandom | head -c "$pwlength" | xargs
	done
}


#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Additonal software
#
which gnuplot > /dev/null && alias plot='gnuplot' && alias gp='gnuplot'

# Wireshark over SSH
if which wireshark > /dev/null; then
	function wireshark-ssh () {
		ssh $@ tcpdump -U -s0 -w - 'not port 22' | wireshark -k -i -
	}
fi

# Xfig: use special LaTeX fonts for easy pdf_t export
if which xfig > /dev/null && which latex > /dev/null; then
	export Fig.latexfonts=true
	export Fig.specialtext=true
	alias xfig='xfig -specialtext -latexfonts -startlatexFont default'
fi

# MySQL
if [ -d /usr/local/mysql/bin ]; then
	export PATH=$PATH:/usr/local/mysql/bin
fi

# Plant UML
if [ -f /usr/local/lib/plantuml.jar ]; then
	alias plantuml="java -jar /usr/local/lib/plantuml.jar"
fi

# Screen and serial console
if which screen > /dev/null; then
	alias console='screen /dev/tty.usbserial'
fi
#-----------------------------------------------------------------------------

