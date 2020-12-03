#!/usr/bin/env bash

SOURCE="https://github.com/iammcgaber/dotfiles"
TARBALL="$SOURCE/tarball/master"
TARGET="$HOME/.dotfiles"
TAR_CMD="tar -xzv -C "$TARGET" --strip-components=1 --exclude='{.gitignore}'"
OS_NAME=""

is_executable() {
  type "$1" > /dev/null 2>&1
}

check_prereq () {
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Darwin*)    if ! is_executable "xcode-select"; then
                    sudo softwareupdate -i -a
                    xcode-select --install
                  fi
                  ;;
      Linux*)     if ! is_executable "git"; then
                    sudo apt-get update && sudo apt-get install git curl wget
                  fi
                  ;;
      *)          echo "OS not supported" && exit 1;;
  esac
}

check_prereq

if is_executable "git"; then
  CMD="git clone $SOURCE $TARGET"
elif is_executable "curl"; then
  CMD="curl -#L $TARBALL | $TAR_CMD"
elif is_executable "wget"; then
  CMD="wget --no-check-certificate -O - $TARBALL | $TAR_CMD"
fi

if [ -z "$CMD" ]; then
  echo "No git, curl or wget available. Aborting."
else
  echo "Installing dotfiles..."
  mkdir -p "$TARGET"
  eval "$CMD"
fi
