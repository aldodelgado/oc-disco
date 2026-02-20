# General Aliases
alias cat='bat'
alias csv='csvtk pretty'
alias ports='lsof -i -P -n | grep LISTEN'

# OpenClaw Aliases
alias occstatus='openclaw channels status --probe'
alias ocgstart='openclaw gateway start'
alias ocgstop='openclaw gateway stop'
alias ocgtatus='openclaw gateway status'
alias ocgunload='launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/ai.openclaw.gateway.plist'
alias ochealth='openclaw health'
alias oclogs='openclaw logs --follow --local-time'
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

