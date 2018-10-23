#!/usr/bin/env bash

brew install tmux
brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting

# Switch to using brew-installed zsh as default shell
if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/zsh;
fi;


# Setup prompt
npm install --global pure-prompt

# Docker completions
mkdir -p ~/.zsh/completion
ln -s /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion ~/.zsh/completion/_docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion ~/.zsh/completion/_docker-compose

mkdir -p ~/.zfunctions

# Symlink prompt-files
for file in kubectl-prompt/*; do
  filename=$(basename $file)
	[ -r "$file" ] && [ -f "$file" ] && ln -fs "$(pwd {BASH_SOURCE[0]})/$file" ~/.zfunctions/$filename;
done

for file in pure-prompt/*; do
  filename="$(basename $file)"
	[ -r "$file" ] && [ -f "$file" ] && ln -fs "$(pwd {BASH_SOURCE[0]})/$file" ~/.zfunctions/$filename;
done
