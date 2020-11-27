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


dayOfMonth=$(date +%Oe | sed 's/ //')
# dayOfMonth="1"
# dayOfMonth="2"
# dayOfMonth="3"
# dayOfMonth="4"
# dayOfMonth="11"
# dayOfMonth="21"
# dayOfMonth="22"
# dayOfMonth="23"
# dayOfMonth="24"

dayOfMonthLength=${#dayOfMonth}

# Handle most numbers
case "${dayOfMonth:dayOfMonthLength-1:1}" in
    1)
    postfix="st"
    ;;
    2)
    postfix="nd"
    ;;
    3)
    postfix="rd"
    ;;
    *)
    postfix="th"
    ;;
esac

# Handle numbers starting with "1"
case "${dayOfMonth:0:1}" in
    1)
    postfix="th"
    ;;
esac

dayOfWeek=$(date +%a)
dayOfWeekShortened=$(echo $dayOfWeek | head -c 2)
dayOfMonth=$dayOfMonth$postfix
month=$(date +%b)
# date="$(date '+%m-%d')"
time="$(date '+%H:%M')"

# echo -e "${COLOUR_GREEN}$time${STYLE_CLEAR} ${STYLE_DEFAULT_TEXT}$dayOfMonth $month${STYLE_CLEAR} | size=12"
echo -e "${STYLE_DEFAULT_TEXT}$time $dayOfWeekShortened $dayOfMonth $month${STYLE_CLEAR} | size=12"

echo "---"

echo "$(date '+%l:%M:%S %p')"
echo "$(date '+%A, %d %B %Y')"
echo "Day $(date '+%j')"
echo "Week $(date '+%V')"

echo "---"

year=$(date +%Y)
calendar_font_family="Menlo"
color="white"
calendar_font_size="11"
previous_month_color="white"
next_month_color="white"
last_m=$(date -v-1m +%m)
last_m_name=$(date -jf %Y-%m-%d "$year"-"$last_m"-01 '+%b')
next_m=$(date -v+1m +%m)
next_m_name=$(date -jf %Y-%m-%d "$year"-"$next_m"-01 '+%b')

#Uncomment the below line and comment out all other following lines to trigger the three-month mode
# cal -3 |awk 'NF'|sed 's/ $//' |while IFS= read -r i; do echo " $i|trim=false font=$calendar_font_family size=$calendar_font_size color=$color"|  perl -pe '$b="\b";s/ _$b(\d)_$b(\d) /(\1\2)/' |perl -pe '$b="\b";s/_$b _$b(\d) /(\1)/'  ; done

echo "---"

# cal | awk 'NF' | sed 's/ $//' | while IFS= read -r i; do echo " $i|trim=false font=$calendar_font_family size=$calendar_font_size color=$color" | perl -pe '$b="\b";s/ _$b(\d)_$b(\d) /(\1\2)/' | perl -pe '$b="\b";s/_$b _$b(\d) /(\1)/'; done
cal | awk 'NF' | sed 's/ $//' | while IFS= read -r i; do echo " $i|trim=false font=$calendar_font_family size=$calendar_font_size color=$color" | perl -pe '$b="\b";s/ _$b(\d)_$b(\d) /(\1\2)/' | perl -pe '$b="\b";s/_$b _$b(\d) /(\1)/'; done
# cal | awk '{ \
#   print " "$0; \
#   getline; \
#   print " Mo Tu We Th Fr Sa Su"; \
#   getline; \
#   if (substr($0,1,2) == " 1") print "                    1 "; \
#   do { \
#     prevline=$0; \
#     if (getline == 0) exit; \
#     print " " substr(prevline,4,17) " " substr($0,1,2) " "; \
#   } \
#   while (1) \
# }'

echo "---"

# Previous Month
echo "Last Month: $last_m_name, $year|trim=false"
cal -d "$year"-"$last_m" | awk 'NF' | sed 's/ *$//'| while IFS= read -r i; do echo "--$i|trim=false font=$calendar_font_family size=$calendar_font_size color=$previous_month_color"; done 

# Next Month
echo "Next Month: $next_m_name, $year|trim=false"
cal -d "$year"-"$next_m" | awk 'NF' | sed 's/ *$//' | while IFS= read -r i; do echo "--$i|trim=false font=$calendar_font_family size=$calendar_font_size color=$next_month_color";done
# cal -d "$year"-"$next_m" | awk '{ print " "$0; getline; print " Mo Tu We Th Fr Sa Su"; getline; if (substr($0,1,2) == " 1") print "                    1 "; do { prevline=$0; if (getline == 0) exit; print " " substr(prevline,4,17) " " substr($0,1,2) " "; } while (1) }'; done

echo "---"

echo "Open Date & Time Preferences... | bash='$0' param1='openSystemPreferencesDateAndTimePane' terminal=false"
