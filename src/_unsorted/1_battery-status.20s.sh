#!/bin/bash

# <bitbar.title>Battery Saver</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Displays minimal battery information and highlights when to unplug / plug in AC power to keep your battery in the 40% - 80% range.</bitbar.desc>
# <bitbar.image>https://barryels.github.io/bitbar-plugins/src/battery-status/image.png</bitbar.image>


MIN_BATTERY_LEVEL=40
MAX_BATTERY_LEVEL=80


BATTERY_DISCHARGING_SEARCH_TERM="discharging"


battery_info=$(pmset -g batt | egrep "([0-9]+\%).*" -o)


battery_level=$(echo $battery_info | cut -f1 -d';' | grep -o '[0-9]\+')
battery_remaining_time=$(echo $battery_info | grep -oE '[0-9]+\:[0-9]{2}')
battery_remaining_time="($battery_remaining_time)"
is_battery_charging="yes"

if echo "$battery_info" | grep -q "$BATTERY_DISCHARGING_SEARCH_TERM";
then
    is_battery_charging="no";
fi

TRACKPAD_BATTERY_PERCENTAGE=$(ioreg -n BNBTrackpadDevice | fgrep BatteryPercent | fgrep -v \{ | sed 's/[^[:digit:]]//g')


# Testing
# battery_level=39
# battery_remaining_time=""
# battery_charging_status="charging"
# battery_charging_status="discharging"

# icon_lightning_bolt="⚡"


if [ "$battery_remaining_time" = "()" ]; then battery_remaining_time="..."; fi
if [ "$battery_remaining_time" = "(0:00)" ]; then battery_remaining_time=""; fi

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


echo -e "$battery_level$status_icon $battery_remaining_time | size=12"
if [ "$TRACKPAD_BATTERY_PERCENTAGE" ]; then
	echo "Trackpad: $TRACKPAD_BATTERY_PERCENTAGE%"
fi
