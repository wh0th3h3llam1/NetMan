#!/bin/bash
# GitHub : http://github.com/wh0th3h3llam1
# Author : wh0th3h3llam1

# Bash script to check if your device has an internet connection.
# It will check for internet connection every n seconds.
# If state is changed, the script will notify you and also play a sound.
# By default, the script will play hike-msg-tone when internet is restored.
# By default, the script will play iphone-msg-tone when internet is lost.


function init()
{
	flag=0
	prev=0
	printf "Enter Delay in Seconds (Default Value is 10 Sec): "
	read delay

	# Check if user input is null.
	# If null, then it will assign 10 as default to delay variable.
	if [ -z $delay ]
	then
		delay=10
	fi
}


function net_check()
{
	while(true);
	do

		if ping -q -c 1 -W 1 google.com > /dev/null;
		then
			# echo "The Network is Up."
			flag=1
		else
			# echo "The Network is Down".
			flag=0
		fi

		if [[ $prev -ne $flag ]]; then

			prev=$flag
			# killall notify-send
			if [[ $flag -eq '0' ]]; then
				notify-send "The Network is Down" "You will be Notified when Internet is Restored." -t 2500 --hint=int:transient:1
				# Make sure you keep the
				play "~/Music/iphone-msg-tone.wav" > /dev/null

			else
				notify-send "Your Internet Connection has been Restored." "You can surf the Internet now." -t 2500 --hint=int:transient:1
				# Make sure you keep the
				play "~/Music/hike-msg-tone.wav" > /dev/null

			fi
			# play "~/Music/iphone (mp3cut.net).wav" > /dev/null
			# play "~/Music/iphone.mp3" > /dev/null
		fi

		sleep $delay;

	done
}


init
net_check


#wh0am1
