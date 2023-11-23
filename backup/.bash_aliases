alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias cdf='cd $(find * -type d | fzf)'

alias py3='python3'


# Git
function gitcheckout() {
  if [ ! -d ./.git ]; then
    echo "$(pwd) is NOT a git directory"
    return 0
  fi
  git checkout $(git branch | fzf)
}
function gitdiff() {
  if [ ! -d ./.git ]; then
    echo "$(pwd) is NOT a git directory"
    return 0
  fi
  git diff $(git status -s | sed 's/^...//g' | fzf) 
}


function mkcd() {
  # `$_` stands for last arguement of previous command
  mkdir -p "$@" && cd "$_";
}

function cdplus() {
  local in_dir
  local push_dir

  [ ! -f ~/.visited_dirs ] && { echo "please create ~/.visited_dirs first!"; return 1; }

  [ $# -gt 1 ] && { echo "too manyt parameters"; return 3; }


  # trick: no parameter launch fzf!
  if [ $# -eq 0 ]; then
    in_dir=$(cat ~/.visited_dirs | tac | head -n30 | fzf )
    in_dir=$( echo "$in_dir" | sed "s|~|$HOME|g" )
  else
    in_dir=$1
  fi

  [[ ! -d "$in_dir" ]] && { echo ""$in_dir" is not a directory"; return 2; }


  # update the recently visited dir
  push_dir=$( realpath "$in_dir" | sed "s|$HOME|~|g" )
  
  if [[ "$push_dir" == "~" ]]; then
    echo "[DEBUG] don't push homepath"
  else
    echo "[DEBUG] pushed_dir: "$push_dir""
    sed -i "\:^$push_dir$:d" ~/.visited_dirs
    echo "$push_dir" >> ~/.visited_dirs
  fi

  builtin cd "$in_dir"
  return 0
}

function proxy() {
    export http_proxy=http://127.0.0.1:7890
    export https_proxy=$http_proxy
    
    # npm
    npm config set proxy=http://127.0.0.1:7890
    npm config set https-proxy http://127.0.0.1:7890
    echo -e "proxy on!"
}
function unproxy(){
    unset http_proxy https_proxy

    npm config delete proxy
    npm config delete https-proxy
    echo -e "proxy off"
}

alias cd=cdplus
