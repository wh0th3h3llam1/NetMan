#!/bin/bash
# GitHub : http://github.com/wh0th3h3llam1
# Author : wh0th3h3llam1

# Bash script to check if your device has an internet connection.
# It will check for internet connection every n seconds.
# If state is changed, the script will notify you and also play a sound.
# By default, the script will play hike-msg-tone when internet is restored.
# By default, the script will play iphone-msg-tone when internet is lost.


function logo()
{
	echo "			_	   ___					_ "
	echo "__      _| |__  / _ \  __ _ _ __ ___ / |"
	echo "\ \ /\ / / '_ \| | | |/ _\` | '_ \` _ \| |"
	echo " \ V  V /| | | | |_| | (_| | | | | | | |"
	echo "  \_/\_/ |_| |_|\___/ \__,_|_| |_| |_|_|"
	echo "										v0.1"
}


function setup()
{
	# Install wget if not found
	if ! [ -x "$(command -v wget)" ]; then
		echo -e "[SETUP] Installing 'wget'...\n\n"
		sudo apt-get install wget
		echo -e "\n\n"
	fi

	# Install at package if not found
	if ! [ -x "$(command -v at)" ]; then
		echo -e "[SETUP] Installing 'AT'...\n\n"
		sudo apt-get install at
		echo -e "\n\n"
	fi

	# Install sox if not found
	if ! [ -x "$(command -v sox)" ]; then
		echo -e "[SETUP] Installing 'sox'...\n\n"
		sudo apt-get install sox
		sudo apt-get install sox libsox-fmt-all
		echo -e "\n\n"
	fi

	# Download the Notification Sound if this is first time
	# Add alias to the bashrc file
	if ! [ -f ~/NetMan/hike-msg-tone.wav ]; then
		echo -e "Downloading Notification Sounds...\n\n"

		touch ~/NetMan/hike-msg-tone.wav | wget -O ~/NetMan/hike-msg-tone.wav "https://raw.githubusercontent.com/wh0th3h3llam1/NetMan/master/hike-msg-tone.wav"

		touch ~/NetMan/iphone-msg-tone.wav | wget -O ~/NetMan/iphone-msg-tone.wav "https://raw.githubusercontent.com/wh0th3h3llam1/NetMan/master/iphone-msg-tone.wav"


		sudo echo "alias netman=\"sh ~/NetMan/netcheck.sh\"" >> ~/.bashrc

		source ~/.bashrc
		echo -e "\n\n"
	fi
}


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

				# Make sure you keep the file in $HOME/Music/
				play "$HOME/Music/iphone-msg-tone.wav" > /dev/null

			else
				notify-send "Your Internet Connection has been Restored." "You can surf the Internet now." -t 2500 --hint=int:transient:1

				# Make sure you keep the file in $HOME/Music/
				play "$HOME/Music/hike-msg-tone.wav" > /dev/null

			fi
		fi

		sleep $delay;

	done
}

logo
setup
init
net_check


# wh0am1

# Written by : wh0am1
# v0.1
