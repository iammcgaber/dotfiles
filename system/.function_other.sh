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
