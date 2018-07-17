#!/bin/bash
# 
# <bitbar.title>Minimal Date and Time</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Displays a minimal date and time.</bitbar.desc>
# <bitbar.image>http://i.imgur.com/h2cyuYu.png</bitbar.image>


COLOUR_RED='\033[0;31m'
COLOUR_GREEN='\033[0;32m'
COLOUR_LIGHT_GRAY='\033[0;37m'

STYLE_CLEAR='\033[0m'
STYLE_DEFAULT_TEXT=$COLOUR_LIGHT_GRAY


function openSystemPreferencesDateAndTimePane {
$(osascript <<EOD
tell application "System Preferences"
	activate
	set the current pane to pane id "com.apple.preference.datetime"
end tell
EOD
)
}


if [ "$1" = "openSystemPreferencesDateAndTimePane" ]
then
	echo $(openSystemPreferencesDateAndTimePane)
fi


date="$(date '+%d/%m')"
time="$(date '+%H:%M')"

echo -e "${COLOUR_GREEN}$time${STYLE_CLEAR} ${STYLE_DEFAULT_TEXT}($date)${STYLE_CLEAR} | size=12"

echo "---"

echo "$(date '+%A, %d %B %Y')"
echo "Day $(date '+%j')"
echo "Week $(date '+%W')"

echo "---"

echo "Open Date & Time Preferences... | bash='$0' param1='openSystemPreferencesDateAndTimePane' terminal=false"
