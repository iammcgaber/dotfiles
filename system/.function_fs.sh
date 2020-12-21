# Create a new directory and enter it

mkcd() {
  mkdir -p "$@" && cd "$@"
}

# Fuzzy find file/dir

ff() { find . -type f -iname "*$1*";}
fd() { find . -type d -iname "*$1*";}


# Show disk usage of current folder, or list with depth

duf() {
  du --max-depth=${1:-0} -c | sort -r -n | awk '{split("K M G",v); s=1; while($1>1024){$1/=1024; s++} print int($1)v[s]"\t"$2}'
}

# Check if resource is served compressed

check_compression() {
  curl --write-out 'Size (uncompressed) = %{size_download}\n' --silent --output /dev/null $1
  curl --header 'Accept-Encoding: gzip,deflate,compress' --write-out 'Size (compressed) =   %{size_download}\n' --silent --output /dev/null $1
  curl --head --header 'Accept-Encoding: gzip,deflate' --silent $1 | grep -i "cache\|content\|vary\|expires"
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

# Get gzipped file size

gz() {
  local ORIGSIZE=$(wc -c < "$1")
  local GZIPSIZE=$(gzip -c "$1" | wc -c)
  local RATIO=$(echo "$GZIPSIZE * 100/ $ORIGSIZE" | bc -l)
  local SAVED=$(echo "($ORIGSIZE - $GZIPSIZE) * 100/ $ORIGSIZE" | bc -l)
  printf "orig: %d bytes\ngzip: %d bytes\nsave: %2.0f%% (%2.0f%%)\n" "$ORIGSIZE" "$GZIPSIZE" "$SAVED" "$RATIO"
}

# Create a data URL from a file

dataurl() {
  local MIMETYPE=$(file --mime-type "$1" | cut -d ' ' -f2)
  if [[ $MIMETYPE == "text/*" ]]; then
    MIMETYPE="${MIMETYPE};charset=utf-8"
  fi
  echo "data:${MIMETYPE};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Tree

t() {
  tree -AdL ${1:-1}
}

#Go up n directories
function cd_up() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
}

#Move item to Mac trash
function trash() {
  command mv "$@" ~/.Trash
}