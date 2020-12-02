# Shortcuts

alias sourcebash="source ~/.bash_profile"
alias _="sudo"
alias g="git"
alias rr="rm -rf"

# Default options

alias rsync="rsync -vh"
alias psgrep="psgrep -i"

# Global aliases

if $(is-supported "alias -g"); then
  alias -g G="| grep -i"
  alias -g H="| head"
  alias -g T="| tail"
  alias -g L="| less"
fi

# List declared aliases, functions, paths

alias aliases="alias | sed 's/=.*//'"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'

# Directory listing/traversal

LS_COLORS=$(is-supported "ls --color" --color -G)
LS_TIMESTYLEISO=$(is-supported "ls --time-style=long-iso" --time-style=long-iso)
LS_GROUPDIRSFIRST=$(is-supported "ls --group-directories-first" --group-directories-first)

alias l="ls -h1a $LS_COLORS $LS_TIMESTYLEISO $LS_GROUPDIRSFIRST"
alias lt="ls -alF $LS_COLORS"
alias ll="ls -lhAtr $LS_COLORS $LS_TIMESTYLEISO $LS_GROUPDIRSFIRST"
alias ld="ls -ld $LS_COLORS */"
alias lp="stat -c '%a %n' *"

unset LS_COLORS LS_TIMESTYLEISO LS_GROUPDIRSFIRST

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"                  # Go to previous dir with -
alias cd.='cd $(readlink -f .)'    # Go to real dir (i.e. if current dir is linked)
alias 'cd..'='cd_up'               # Go up n number of directory levels

# npm

alias ni="npm install"
alias nu="npm uninstall"
alias nup="npm update"
alias nri="rm -r node_modules && npm install"
alias ncd="npm-check -su"

# Network

alias ip="curl -s ipinfo.io | jq -r '.ip'"
alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'

# Request using GET, POST, etc. method

for METHOD in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$METHOD"="lwp-request -m '$METHOD'"
done
unset METHOD

# File Reading

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias grip="grip -b"

# System

alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
alias qfind="find . -name "

#iTerm2

alias imgcat='~/.iterm2/imgcat'
alias imgls='~/.iterm2/imgls'
alias it2attention='~/.iterm2/it2attention'
alias it2check='~/.iterm2/it2check'
alias it2copy='~/.iterm2/it2copy'
alias it2dl='~/.iterm2/it2dl'
alias it2getvar='~/.iterm2/it2getvar'
alias it2setcolor='~/.iterm2/it2setcolor'
alias it2setkeylabel='~/.iterm2/it2setkeylabel'
alias it2ul='~/.iterm2/it2ul'
alias it2universion='~/.iterm2/it2universion'

# Git

alias gb='git branch'
alias gis='git status'
alias gaa='git add .'
alias gcm='git commit -m'
alias gld='git log --oneline --pretty=format:"%C(Yellow) %h %Cgreen %ad %Cred | %C(white) %s%d %C(magenta)[%an]" --graph --date=short'
alias glda='git log --oneline --pretty=format:"%C(Yellow) %h %Cgreen %ad %Cred | %C(white) %s%d %C(magenta)[%an]" --graph --date=short --all'
alias gpom='git push origin HEAD:refs/for/develop'
alias gpr='git pull --rebase'
alias allprojects='git ls-projects'
alias gap='git add -p'
alias gcne='git commit --amend --no-edit'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gpoh='git push origin HEAD'
alias gp='git push'
alias gascm='git add .; git status; git commit -m '
alias git-rm-deleted="git ls-files -d | xargs git rm"
alias gl='clear && git status'

# Miscellaneous

alias cl='clear && ll'
alias hosts="sudo $EDITOR /etc/hosts"
alias quit="exit"
alias week="date +%V"
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"
alias dad='curl https://icanhazdadjoke.com/ && echo ""'