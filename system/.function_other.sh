#Go up n directories
function cd_up() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
}

#Create a directory and change into it
function mkcd() {
  mkdir -p "$*" && cd "$*"
}

#Move item to Mac trash
function trash() {
  command mv "$@" ~/.Trash
}

#Function to easitly extract many types of packages
function extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

#Pretty JSON print something
function json() {
  jq '.' $1
}

function git_fetch() {
    branch=${1}
    git fetch origin ${branch}:${branch} && git checkout ${branch}
}

function set_upstream() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git branch -u origin ${current_branch}
}

function git_clone() {
    repo=$1
    dir_name=$(basename -s .git ${repo})
    git clone ${repo} && cd ${dir_name}
}

function git_set_work() {
  git config user.name ${WORK_NAME}
  git config user.email ${WORK_EMAIL}
}

function git_set_personal() {
  git config user.name ${PERSONAL_NAME}
  git config user.email ${PERSONAL_EMAIL}
}

# Switch long/short prompt
ps0() {
  unset PROMPT_COMMAND
  PS1='$ '
}

ps1() {
  source "$DOTFILES_DIR"/system/.prompt
}

# Get named var (usage: get "VAR_NAME")

get() {
  echo "${!1}"
}

# Add to path

prepend-path() {
  [ -d $1 ] && PATH="$1:$PATH"
}

# Show 256 TERM colors

colors() {
  local X=$(tput op)
  local Y=$(printf %$((COLUMNS-6))s)
  for i in {0..256}; do
  o=00$i;
  echo -e ${o:${#o}-3:3} $(tput setaf $i;tput setab $i)${Y// /=}$X;
  done
}

# Calculator

calc() {
  echo "$*" | bc -l;
}

# Weather

meteo() {
  local LOCALE=$(echo ${LANG:-en} | cut -c1-2)
  if [ $# -eq 0 ]; then
    local LOCATION=$(curl -s ipinfo.io/loc)
  else
    local LOCATION=$1
  fi
  curl -s "$LOCALE.wttr.in/$LOCATION"
}

# Markdown

md() {
  pandoc $1 | lynx -stdin -dump
}
