# enable color support of ls if it seems available
export GREP_COLOR=33
USE_COLOR_CMDS=""

# for a mac
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

if [ ! -z "$USE_COLOR_CMDS" ]; then
  # Highlight search term in grep
  alias grep='grep --color=auto --line-number'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
unset USE_COLOR_CMDS

export LS_CMD="ls"
alias ls="$LS_CMD"
alias ll="$LS_CMD -al"
alias la="$LS_CMD -A"
alias l="$LS_CMD -lahrtc"
alias gk="gitk 2> /dev/null"
alias ts="cd ~/workspace/townhall_server"
alias is="cd ~/workspace/ionic_api_server"

# Syntax highlighting for less (-R for RAW ^ colors)
alias less='less -R'

alias path='echo $PATH'

# Interactive delete
alias rm='rm -i'

# Verbosely show progress for move and copy
alias cp='cp -v'
alias mv='mv -v'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Fully update operating system
if [ -f /etc/debian_version ]; then
  alias update_system="sudo bash -c 'apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove'"
elif [ -f /etc/redhat-release ]; then
  alias update_system="sudo bash -c 'yum -y update'"
elif [ $(uname -s) = "Darwin" ]; then
  alias update_system="brew update && brew upgrade"
fi

# Simulate OSX's pbcopy and pbpaste on other platforms
if [ ! $(uname -s) = "Darwin" ]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

function get_token()
{
  . resty
  resty http://localhost:3000
  KEY=2237c2051d9355c0e3981804b62b4e61455ede1564df948e1a556b7690b5a690
  TOKEN=`resty PUT /access_token.json -d "access_token[username]=joe&access_token[password]=pass1234&access_token[app_api_key]=$KEY" |
            jsawk 'return this.access_token.id'`
  resty http://localhost:3000 -H "IM-AccessToken: $TOKEN"
  echo "Logged in as $USER"
}

function get_token_local()
{
  . resty
  resty http://localhost:3000
  KEY=2237c2051d9355c0e3981804b62b4e61455ede1564df948e1a556b7690b5a690
  echo "username:"
  read username
  echo "password:"
  read -s password
  TOKEN=`resty PUT /access_token.json -d "access_token[username]=$username&access_token[password]=$password&access_token[app_api_key]=$KEY" |
            jsawk 'return this.access_token.id'`
  resty http://localhost:3000 -H "IM-AccessToken: $TOKEN"
  echo "Logged in as $username"
}

function get_mobile_token()
{
  . resty
  resty http://mobiledev-ionicmobile.asolutions.com
  KEY=2237c2051d9355c0e3981804b62b4e61455ede1564df948e1a556b7690b5a690
  echo "username:"
  read username
  echo "password:"
  read -s password
  TOKEN=`resty PUT /access_token.json -d "access_token[username]=$username&access_token[password]=$password&access_token[app_api_key]=$KEY" |
            jsawk 'return this.access_token.id'`
  resty http://mobiledev-ionicmobile.asolutions.com -H "IM-AccessToken: $TOKEN"
  echo "Logged in as $username"
}

function get_demo_token()
{
  . resty
  resty http://demo-ionicmobile.asolutions.com
  echo "username:"
  read username
  echo "password:"
  read -s password
  TOKEN=`resty PUT /access_token.json -d "access_token[username]=$username&access_token[password]=$password" |
            jsawk 'return this.access_token.id'`
  resty http://demo-ionicmobile.asolutions.com -H "IM-AccessToken: $TOKEN"
  echo "Logged in as $username"
}

function get_qa_token()
{
  . resty
  resty http://qa-ionicmobile.asolutions.com
  KEY=3ac6607abbdb98e1063f4f63a4369278b9ba0de47284a40f097de13faa22aa5c
  TOKEN=`resty PUT /access_token.json -d "access_token[username]=joe&access_token[password]=pass1234&access_token[app_api_key]=$KEY" |
            jsawk 'return this.access_token.id'`
  resty http://qa-ionicmobile.asolutions.com -H "IM-AccessToken: $TOKEN"
}

function get_staging_token()
{
  . resty
  resty https://staging-ionicmobile.asynchrony.com
  KEY=9118d6a5f4f3818acc287ec117ee8d767a83b39ce1332efe468ce004bd26e863
  echo "username:"
  read username
  echo "password:"
  read -s password
  TOKEN=`resty PUT /access_token.json -d "access_token[username]=$username&access_token[password]=$password&access_token[app_api_key]=$KEY" |
            jsawk 'return this.access_token.id'`
  resty https://staging-ionicmobile.asynchrony.com -H "IM-AccessToken: $TOKEN"
}

function get_prod_token()
{
  . resty
  resty https://ionicmobile.asolutions.com
  echo "api key:"
  read KEY
  echo "username:"
  read username
  echo "password:"
  read -s password
  TOKEN=`resty PUT /access_token.json -d "access_token[username]=$username&access_token[password]=$password&access_token[app_api_key]=$KEY" |
            jsawk 'return this.access_token.id'`
  resty https://ionicmobile.asolutions.com -H "IM-AccessToken: $TOKEN"
}

function commit(){
  echo "Pair initials:"
  read INITIALS
  git pair $INITIALS
  echo "Commit Message:"
  read MESSAGE
  git ci -m "$MESSAGE"
}
alias stop_elastic_search="launchctl unload -wF ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist"
alias start_elastic_search="launchctl load -wF ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist"

for FILE in ~/dotfiles/*/aliases.sh; do
  source $FILE
done

alias start_nginx="sudo launchctl start homebrew.mxcl.nginx"
alias stop_nginx="sudo launchctl stop homebrew.mxcl.nginx"
alias restart_nginx="stop_nginx && start_nginx"

alias nuke_dbs="rm -f dbs/development.sqlite3 dbs/test.sqlite3; rake db:migrate; RACK_ENV=test rake db:migrate"
