#!/bin/bash

# <bitbar.title>Battery Saver</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Displays minimal battery information and highlights when to unplug / plug in AC power to keep your battery in the 40% - 80% range.</bitbar.desc>
# <bitbar.image>http://i.imgur.com/h2cyuYu.png</bitbar.image>


MIN_BATTERY_LEVEL=40
MAX_BATTERY_LEVEL=80


battery_level=$(ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.0f"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}')
battery_is_charging=$(ioreg -n AppleSmartBattery -r | grep 'IsCharging' | awk '{print $3}')
# time_remaining=$(ioreg -n AppleSmartBattery -r | grep 'TimeRemaining' | awk '{print $3}')
time_remaining=( $(pmset -g batt | awk -F";" 'FNR == 2 {print $3}') )

# Testing
# battery_level=39
# battery_is_charging="No"


if [ "$time_remaining" = "(no" ]; then time_remaining="..."; fi


if [ "$battery_is_charging" = "Yes" ]
then
	status_icon="↑"

	if [ "$battery_level" -ge "$MAX_BATTERY_LEVEL" ]
		then
			status_icon="✓"
	fi

else
	status_icon="↓"

	if [ "$battery_level" -le "$MIN_BATTERY_LEVEL" ]
		then
			status_icon="✕"
	fi

fi



echo -e "$battery_level$status_icon$time_remaining | size=12"
