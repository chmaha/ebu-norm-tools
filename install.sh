#!/bin/bash
# Installer for ebu-norm, tp-norm and ebu-scan
# Copyright © 2021 chmaha

echo "This script will install batch normalizer/scanner scripts to usr/local/bin"
read -p "Do you wish to continue?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Making scripts executable..."
	sleep 1
	chmod +x ebu-norm tp-norm ebu-scan ebu-plot
	echo "Copying scripts to usr/local/bin..."
	sleep 1
	cp ebu-norm tp-norm ebu-scan ebu-plot ebu-plot.psl /usr/local/bin

	# Check for sound-gambit and offer to install if not available
	which sound-gambit >/dev/null 2>&1
	ret=$?
	if [ $ret -ne 0 ]
	then
		echo "Sound Gambit is required by ebu-norm but was not found."
		sleep 3
		echo "Downloading latest sound-gambit binary..."
		sudo -u	$SUDO_USER wget https://github.com/x42/sound-gambit/releases/latest/download/sound-gambit.linux >/dev/null 2>&1
		echo "Installing sound-gambit to /usr/local/bin..."
		sleep 1
		chmod +x sound-gambit.linux
		mv sound-gambit.linux /usr/local/bin/sound-gambit
	else
		:
	fi
	echo "Done!!"
fi

