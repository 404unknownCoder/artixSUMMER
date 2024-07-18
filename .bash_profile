#
# ~/.bash_profile
#
l rc ]] && source ~/.bashrc
	[[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx
else
	exit 1
fi
