#!/bin/bash

# <bitbar.title>Walkie Talkie</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Mute/Unmute microphone</bitbar.desc>
# <bitbar.image>http://i.imgur.com/h2cyuYu.png</bitbar.image>

COLOUR_RED='\033[0;31m'
COLOUR_GREEN='\033[0;32m'

input_volume=$(osascript -e 'input volume of (get volume settings)')

if [ "$input_volume" = 0 ];
  then
    status_icon="•";
    echo -e "${COLOUR_RED}$status_icon | size=20"
  else
    status_icon="•";
    echo -e "${COLOUR_GREEN}$status_icon | size=20"
fi

# echo -e "$status_icon | size=12"
