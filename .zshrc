# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

fpath=("$HOME/.zsh/completion" "$HOME/.zfunctions" $fpath)

# Fish-like syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

for file in ~/.{paths,prompt,exports,aliases,functions,extra,auths,historyopts}; do
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

if type kubectl > /dev/null ; then
	source <(kubectl completion zsh)
fi