# Setup
Upgrade to latest OsX version...

## Install OS
1. Boot to Recovery OS by restarting your machine and holding down the Command and R keys at startup.
2. Format with case sensitive file system
3. Install OsX

## Disable SIP
1. Boot to Recovery OS
2. Launch Terminal from the Utilities menu.
3. Enter the following command:

		$ csrutil disable
4. Boot

## Setup OS

1. Open `Terminal` and run:

		$ git
2. Wait for Command Line Developer Tools to install, then:

		$ git clone https://github.com/pliljenberg/dotfiles.git && cd dotfiles && ./install.sh


## iTerm
Open preferences (`CMD + ;`) and under `Profiles/General` edit `Send text as start`.

    tmux attach -t init || tmux new -s init

Under `Profiles/Colors` change `Color presets...` to `peter``

