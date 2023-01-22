# history
HISTSIZE=50000
SAVEHIST=10000

# DEFAULT_USER="<name>"
DEFAULT_USER=`whoami`

source ~/antigen.zsh

antigen bundles <<EOBUNDLES
  command-not-found
  colored-man-pages
  MichaelAquilina/zsh-you-should-use
  z
  # zsh-users/zsh-autosuggestions
  # zsh-users/zsh-completions
  # zsh-users/zsh-syntax-highlighting
EOBUNDLES
antigen apply

setopt auto_cd


# prefer US English & utf-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

# Homebrew
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_BUNDLE_FILE="~/Brewfile"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:${PATH}"
eval "$(starship init zsh)"

# Add Deno scripts to path
export PATH="/Users/rcrosser/.deno/bin:$PATH"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"


# load the rest of the configs
source $HOME/.aliases

export PATH="$PATH:/Users/rcrosser/.kit/bin"

# pnpm
export PNPM_HOME="/Users/rcrosser/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# make new dir and cd into it
take() {
	mkdir -p $1
	cd $1
}

dev-browser () {
  URL=""

  re_isanum='^[0-9]+$'
  if [ $# -eq 0 ] ; then
    URL="http://localhost:8000"
  elif [[ $1 =~ $re_isanum ]] ; then
    URL="http://localhost:$1"
  else
    URL="$1"
  fi

  open -a "Google Chrome" -n "$URL" --args \
    --disable-extensions \
    --disable-component-extensions-with-background-pages \
    --no-default-browser-check \
    --disable-client-side-phishing-detection \
    --disable-default-apps \
    --no-first-run \
    --use-fake-device-for-media-stream \
    --disable-background-timer-throttling \
    --disable-background-networking \
    --disable-breakpad \
    --disable-domain-reliability \
    --disable-sync

  echo "Opening "$URL" in Google Chrome"
}


source ~/.aliases

#####################







port-forward(){
  service=$1
  port=$2

  if [ $# -eq 0 ]; then
    echo "You must provide a port"
    return
  elif [[ "$2" =~ ^[0-9]+$ ]] && [[ "$2" -lt 1 || "$2" -gt 65535 ]]; then
    echo "Invalid port: $2"
    return
  else
    port="$2"
  fi

  ssh -t -i /Users/rcrosser/iowa-admin-dev-20220112.pem -L ${port}:localhost:${port} ec2-user@52.87.224.103;
  sleep 5;
  for i in `env | grep AWS | cut -d '=' -f 1`; do unset $i; done;
  aws sts assume-role --role-arn arn:aws:iam::494101600798:role/EKS-role --role-session-name iowa | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=\(.AccessKeyId)\nexport AWS_SECRET_ACCESS_KEY=\(.SecretAccessKey)\nexport AWS_SESSION_TOKEN=\(.SessionToken)"'
  # aws sts get-caller-identity;
  # kubectl port-forward -n apps svc/$servive $port:$port;
  # bash;
}

# forward(){
#   servive=$1
#   port=$2

#   if [ $# -eq 0 ]; then
#     echo "You must provide a port"
#     return
#   elif [[ "$port" =~ ^[0-9]+$ ]] && [[ "$port" -lt 1 || "$port" -gt 65535 ]]; then
#     echo "Invalid port: $port"
#     return
#   fi

#   for i in `env | grep AWS | cut -d '=' -f 1`; do unset $i; done
#   eval $(aws sts assume-role --role-arn arn:aws:iam::494101600798:role/EKS-role --role-session-name iowa | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=\(.AccessKeyId)\nexport AWS_SECRET_ACCESS_KEY=\(.SecretAccessKey)\nexport AWS_SESSION_TOKEN=\(.SessionToken)\n"')
#   aws sts get-caller-identity

#   eval $(k port-forward -n apps svc/$servive $port:$port)
# }
