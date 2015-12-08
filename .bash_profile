## This is my custom bash_profile. It sets the environment and sources the various .bash* files.
## I decided to separate my preferred bash behaviors into separate files for easier editing and maintenance.

	# include ~/.bash_aliases if it exists
	if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
	fi
	# include ~/.bash_ps1 if it exists
	if [ -f ~/.bash_ps1 ]; then
	. ~/.bash_ps1
	fi
	# include ~/.bash_functions if it exists
	if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
	fi

## The PATHs below make ls and ls colors work. They depend on (GNU/Linux) coreutils.
## Coreutils can be installed on a Mac with Homebrew or MacPorts

	PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
	MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
	PATH="~/.dircolors:$PATH"	
	PATH="/usr/bin/:$PATH"
	
    test -e ~/.dircolors && \
       eval `dircolors -b ~/.dircolors`
	eval $(dircolors -b $HOME/.dircolors)
    
    # Use those colors...
    alias ls="ls --color=always" 
	alias grep="grep --color=always"
	alias egrep="egrep --color=always"
	
## Make sure everything works as expected regardless of where it lives
	if [ "$UID" -eq 0 ]; then
    PATH=$PATH:/usr/local:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
	fi

## complete things that have been typed in the wrong case	
	set completion-ignore-case on 			 		 	 
    	
