#!/bin/bash

# <bitbar.title>Microphone Controller</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Microphone Controller</bitbar.desc>
# <bitbar.image>https://barryels.github.io/bitbar-plugins/src/microphone-controller/image.png</bitbar.image>


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
MIN_MICROPHONE_INPUT_VOLUME=0
MAX_MICROPHONE_INPUT_VOLUME=100


current_microphone_input_volume=$(osascript -e "input volume of (get volume settings)")


if [ "$current_microphone_input_volume" = "0" ];
then
	status_icon="🎙✕"
else
	status_icon="🎙✓"
fi


echo -e "$status_icon | size=12" 

echo "---"

echo -e "Mute | bash=$DIR/microphone-controller/mute.sh terminal=false refresh=true"
echo -e "Unmute | bash=$DIR/microphone-controller/unmute.sh terminal=false refresh=true"

