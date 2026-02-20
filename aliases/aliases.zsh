# General Aliases
alias cat='bat'
alias csv='csvtk pretty'
alias ports='lsof -i -P -n | grep LISTEN'
alias rm='rm -i'

# eza Aliases - ls replacement
alias l1='eza -1   --icons --group-directories-first'
alias la='eza -a   --icons --group-directories-first'
alias lg='eza -lah --icons --git --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'
alias ls='eza -lah --icons --group-directories-first -s extension --color-scale=age --color-scale-mode=gradient'
alias lt='eza -lah --icons --tree --level=2 --group-directories-first'

# OpenClaw Aliases
alias occstatus='openclaw channels status --probe'
alias ocgload='launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.openclaw.gateway.plist'
alias ocgstart='openclaw gateway start'
alias ocgstop='openclaw gateway stop'
alias ocgtatus='openclaw gateway status'
alias ocgunload='launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.openclaw.gateway.plist'
alias ochealth='openclaw health'
alias oclogs='openclaw logs --follow --local-time'
alias ocnload='launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.openclaw.node.plist'
alias ocnstart='openclaw node start'
alias ocnstop='openclaw node stop'
alias ocntatus='openclaw node status'
alias ocnunload='launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.openclaw.node.plist'
alias ocstatus='openclaw status --deep'

# Git Aliases
alias git_sync="git checkout master; git fetch upstream; git merge upstream/master; git push origin master;"
alias clearmerged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'

# Dcoker Aliases
alias dcdown='docker-compose down'
alias dcps='docker-compose ps'
alias dcup='docker-compose up -d'

# Rails Aliases
alias groutes='bundle exec rails routes | grep $@'
alias sc="bundle exec rails console"
alias ss="bundle exec rails server -b 0.0.0.0 -p 3000"
alias sidekiq="bundle exec sidekiq"

# Functions
ts() {
  emulate -L zsh
  setopt localoptions

  local input="${1:-}"
  if [[ -z "$input" ]]; then
    print "Usage: ts <epoch_ms|epoch_s|now>"
    return 2
  fi

  # "now" helper
  if [[ "$input" == "now" ]]; then
    # milliseconds since epoch
    input="$(gdate +%s%3N)"
  fi

  # must be digits
  if [[ ! "$input" =~ '^[0-9]+$' ]]; then
    print "ts: invalid timestamp: $input"
    return 2
  fi

  local secs ms frac
  if (( ${#input} >= 13 )); then
    # treat 13+ digits as milliseconds
    secs=$(( input / 1000 ))
    ms=$(( input % 1000 ))
    frac=".$(printf '%03d' "$ms")"
  else
    # treat as seconds
    secs=$(( input ))
    frac=""
  fi

  # Local time output
  gdate -d "@$secs" +"%Y-%m-%d %H:%M:%S${frac} %Z"
}

trash() {
  # zsh function (not executed during install); keep simple and safe.
  # shellcheck disable=SC2068
  for f in "$@"; do
    local bn=""
    bn="$(basename "$f")"
    while [[ -e "$HOME/.Trash/$bn" ]]; do
      bn="$bn $(date +%H.%M.%S\ %p)"
    done
    mv "$f" "$HOME/.Trash/$bn"
  done
}

