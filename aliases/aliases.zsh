# General Aliases
alias cat='bat'
alias csv='csvtk pretty'
alias ports='lsof -i -P -n | grep LISTEN'

# OpenClaw Aliases
alias ocgatewaystatus='openclaw gateway status'
alias ocgatewaystop='openclaw gateway stop'
alias oclogs='openclaw logs --follow --local-time'
alias ocstatus='openclaw status --deep'
alias ocunload='launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.openclaw.gateway.plist'
alias ochealth='openclaw health'

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

