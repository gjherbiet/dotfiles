# Guillaume-Jean Herbiet's dotfiles

## Structure and flow

* `.bashrc`: a simple call to `.bash_profile` on interactive prompts only
	*  `.bash_profile`: sets default variables and calls, in order:
		* `.bash_exports`: export of default variables
		* `.bash_osx`: Mac OS X specific settings, only on Darwin kernels
		* `.bash_linux`: Linux specific settings, only on Linux kernels
		* `.bash_brew`: Homebrew specific settings, only if `brew` is installed
		* `.bash_git`: Git specific settings, only if `git` is installed
		* `.bash_aliases`: generic aliases and functions
		* `.bash_prompt`: beautify the bash prompt