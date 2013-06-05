for FILE in $HOME/.bash_{exports,osx,linux,brew,git,aliases,prompt}; do
	[ -r "$FILE" ] && source "$FILE"
done
