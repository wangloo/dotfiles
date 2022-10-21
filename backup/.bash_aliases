alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cdf='cd $(find * -type d | fzf)'

# Git
function gitcheckout() {
  if [ ! -d ./.git ]; then
    echo "$(pwd) is NOT a git directory"
    return 0
  fi
  git checkout $(git branch | fzf)
}

function mkcd() {
  # `$_` stands for last arguement of previous command
  mkdir -p "$@" && cd "$_";
}

# TODO LIST
#   1. Check ~/.visited_dirs first
# ✔ 2. Re-support the `cd -` function
# ✔ 3. Don't record home-path 
# ✔ 4. Set waterline
function cdplus() {
  local pushed_dir poped_dir

  if [ $# -gt 1 ]; then
    echo "Too many parameters"
    return 3
  fi

  # Without parameter trigger the magic trap
  if [ $# -eq 0 ]; then
    pushed_dir=$(cat ~/.visited_dirs | tac | head -n30 | fzf )
    [[ -z $pushed_dir ]] && return 2
  else
    pushed_dir=$1
    if [[ ! -d $pushed_dir ]]; then
      echo "$pushed_dir is not a directory"
      return 2;
    fi
    # Preprocess
    pushed_dir=$( realpath $1 | sed "s|$HOME|~|g")
  fi

  case $pushed_dir in
    "~") 
      # Push path excluding home-path
      echo "[Debug] Do not push homepath"
      ;;
    '-') 
      echo "[Debug] return to last visited dir"
      pushed_dir=$(tail -n1 ~/.visited_dirs)
      ;;
    *)
      # Remove any other occurence of this dir
      echo "[Debug] pushed_dir = $pushed_dir"
      sed -i "\:^$pushed_dir$:d" ~/.visited_dirs
      echo "$pushed_dir" >> ~/.visited_dirs
      ;;
  esac

  # Use `eval` because variableexpansion happens just once
  eval builtin cd "$pushed_dir"
  }
alias cd=cdplus
