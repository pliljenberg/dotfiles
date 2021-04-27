# Source Prezto.
unsetopt GLOBAL_RCS
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Disable autocorrect commands
unsetopt CORRECT

# Fish-like syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

for file in ~/.{functions,exports,paths,prompt,aliases,extra,auths,historyopts}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

# Completions
bindkey -M viins '\C-i' complete-word

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Faster! (?)
zstyle ':completion::complete:*' use-cache 1

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

autoload -U promptinit; promptinit
autoload -U colors; colors
autoload -Uz compinit && compinit -i

if type stern > /dev/null ; then
  source <(stern --completion=zsh)
fi

if type kubectl > /dev/null ; then
	source <(kubectl completion zsh)
fi

source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh

if [ -d "${HOME}/.kube/config.d" ];then
  KUBECFG="${HOME}/.kube/config"
  for file in ${HOME}/.kube/config.d/*.yaml; do
    KUBECFG="${KUBECFG}:${file}"
  done
  export KUBECONFIG="${KUBECFG}"
fi


eval "$(direnv hook zsh)"

function powerline_precmd() {
eval "$($GOPATH/bin/powerline-go -condensed -error $? -cwd-mode dironly -shell zsh -eval -cwd-max-depth 0 -modules cwd,dotenv,exit -modules-right aws,git,kube)"
    #eval "$($GOPATH/bin/powerline-go -error $? -condensed -cwd-mode plain  -newline -modules cwd -shell zsh -eval -modules-right git)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

alias mysql='mysql --user=root --host=127.0.0.1 --port=3306 -p'

# AWS SSO
sso(){
  unset AWS_PROFILE
  export AWS_PROFILE=$1
  aws sts get-caller-identity &> /dev/null || aws sso login || (unset AWS_PROFILE && aws-configure-sso-profile --profile $1)
  eval $(aws-export-credentials --env-export)
}
