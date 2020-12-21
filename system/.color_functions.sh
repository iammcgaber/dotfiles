#!/bin/bash

source ${DOTFILES_DIR}/system/.colors.sh
declare color_file=${DOTFILES_DIR}/system/.colors.sh

# Default color.  In bash if you don't end with this the color stays. In zsh not so.
declare def=$'\e[0m'

# List all the color variables to see how they look
function list_colors() {
  cat ${color_file} | \
    while read color; do
      my_color_var=$(echo $color | sed 's/=.*//')
      my_color_name=$(echo $color | sed 's/.* #//')
      if [ -n ${my_color_name} ]; then
        eval echo "\$${my_color_var}\This color is ${my_color_name}${def}"
      fi
    done
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

# Pass a color and text to change the color of that text.
function colorize() {
  local _color=$1
  local _text=$2
  eval echo "\$${_color}\${_text}${def}"
}

# Pass a color name and a style for more dynamic coloring
function color_style() {
  local _color=$1
  local _style=$(get_style $2)
  local _text=$3
  local _color_style=$_style$_color
  eval echo "\$${_color_style}\${_text}${def}"
}

#style_text() {
#  local -r args=$@
#  local styles=''
#  for style in ${args}; do
#    styles+="${style} "
#  done
#  echo "${styles}"
#}

function get_style() {
  local _style=$1
  if [[ "${_style}" == "bold" ]]; then
    echo b
  elif [[ "${_style}" == "underline" ]]; then
    echo u
  elif [[ "${_style}" == "background" ]]; then
    echo bg
  else
    echo
  fi
}

e_header() {
  printf "\n${bold}${purple}==========  %s  ==========${def}\n" "$@"
}

e_arrow() {
  printf "➜ $@\n"
}

e_success() {
  printf "${green}✔ %s${def}\n" "$@"
}

e_error() {
  printf "${red}✖ %s${def}\n" "$@"
}

e_warning() {
  printf "${yellow}➜ %s${def}\n" "$@"
}

e_underline() {
  printf "${underline}${bold}%s${def}\n" "$@"
}

e_bold() {
  printf "${bold}%s${def}\n" "$@"
}