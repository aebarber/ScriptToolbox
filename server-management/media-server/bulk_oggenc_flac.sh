#!/bin/bash

### CONFIGURATION ###

qual="7" #quality (scale -1 (very low) to 10 (very high)) of variable-rate ogg-vorbis audio
# in my experience, I have found quality 7 to be the ideal balance of
# quality and compression for audio that is in flac format. Feel free
# to disagree with me and change this value.

#####################

dir="$1"
if [ "$dir" == "" ]; then
	echo "Directory of FLAC album to convert?"
	read dir
	if [ "$dir" == "" ]; then
		dir="$PWD"
	fi
fi

cd "$dir"
if [ "$?" != "0" ]; then
	echo "Unable to enter directory. Exiting."
	exit
fi
if [ -d "ogg" ]; then
	echo "ogg directory exists. Using it."
	cd "ogg";
	if [ "$?" != "0" ]; then
		echo "Unable to enter ogg directory. Exiting."
		exit
	else
		cd ..
	fi
elif [ ! -e "ogg" ]; then
	echo "Creating ogg directory."
	mkdir ogg
	if [ "$?" != "0" ]; then
		echo "Unable to create ogg directory. Exiting"
		exit
	else
		echo "Ogg directory created."
	fi
else
	echo "ogg exists in directory. Please remove/relocate it. Exiting."
	exit
fi

oggenc -q $qual *.flac
if [ "$?" != "0" ]; then
	echo "oggenc failed. exiting."
	exit
fi
mv *.ogg ogg/
if [ "$?" != "0" ]; then
	echo "unable to move ogg files into ogg directory. exiting."
	exit
fi
cp *.jpg ogg/
cp *.png ogg/

exit

