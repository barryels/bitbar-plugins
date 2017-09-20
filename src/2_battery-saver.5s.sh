#!/bin/bash

# <bitbar.title>Battery Saver</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Displays minimal battery information and highlights when to unplug / plug in AC power to keep your battery in the 40% - 80% range.</bitbar.desc>
# <bitbar.image>http://i.imgur.com/h2cyuYu.png</bitbar.image>


MIN_BATTERY_LEVEL=40
MAX_BATTERY_LEVEL=80


BATTERY_DISCHARGING_SEARCH_TERM="discharging"


battery_info=$(pmset -g batt | egrep "([0-9]+\%).*" -o)


battery_level=$(echo $battery_info | cut -f1 -d';' | grep -o '[0-9]\+')
battery_remaining_time=$(echo $battery_info | grep -oE '[0-9]+\:[0-9]{2}')
is_battery_charging="yes"

if echo "$battery_info" | grep -q "$BATTERY_DISCHARGING_SEARCH_TERM";
then
    is_battery_charging="no";
fi


# Testing
# battery_level=39
# battery_remaining_time=""
# battery_charging_status="charging"
# battery_charging_status="discharging"


if [ "$battery_remaining_time" = "" ]; then battery_remaining_time="..."; fi

if [ "$is_battery_charging" = "yes" ];
then
	status_icon="↑"

	if [ "$battery_level" -ge "$MAX_BATTERY_LEVEL" ];
		then
			status_icon="✓"
	fi

else
	status_icon="↓"

	if [ "$battery_level" -le "$MIN_BATTERY_LEVEL" ];
		then
			status_icon="✕"
	fi

fi


echo -e "$battery_level$status_icon($battery_remaining_time) | size=12"
