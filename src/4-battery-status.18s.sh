#!/bin/bash

# Run this file directly with:
# $ bash -c 'while [ 0 ]; do "./src/2-battery-status.18s.sh"; sleep 2; done'

# <bitbar.title>Battery Saver</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Displays minimal battery information and highlights when to unplug / plug in AC power to keep your battery in the 40% - 80% range.</bitbar.desc>
# <bitbar.image>https://barryels.github.io/bitbar-plugins/src/battery-status/image.png</bitbar.image>


# Directly view battery time remaining:
# $ echo $(pmset -g batt | egrep "([0-9]+\%).*" -o) | grep -oE '[0-9]+\:[0-9]{2}'


### <DataGathering> ###

battery_info=$(pmset -g batt | egrep "([0-9]+\%).*" -o)
more_info=$(system_profiler SPPowerDataType)
battery_level=$(echo $battery_info | cut -f1 -d';' | grep -o '[0-9]\+')
battery_remaining_time=$(echo $battery_info | grep -oE '[0-9]+\:[0-9]{2}')
cycle_count=$(echo "$more_info" | grep "Cycle Count" | awk '{print $3}')
wattage=$(echo "$more_info" | grep "Wattage (W)" | awk '{print $3}')
is_battery_charging="yes"
if echo "$battery_info" | grep -q "discharging"; then is_battery_charging="no"; fi

### </DataGathering> ###



### <Testing> ###

# battery_level=39
# battery_remaining_time=""
# battery_remaining_time="1:30"

# is_battery_charging="no"
# is_battery_charging="yes"

### </Testing> ###



### <DisplayFormatting> ###

COLOUR_RED='\033[0;31m'
COLOUR_GREEN='\033[0;32m'
COLOUR_LIGHT_GRAY='\033[0;37m'
STYLE_CLEAR='\033[0m'
STYLE_DEFAULT_TEXT=$COLOUR_LIGHT_GRAY


if [ "$battery_remaining_time" = "" ]; then battery_remaining_time="..."; fi
if [ "$battery_remaining_time" = "0:00" ]; then battery_remaining_time=""; fi
if [ "$battery_remaining_time" != "" ]; then battery_remaining_time_text=" ($battery_remaining_time)"; fi
suffix="${STYLE_CLEAR}${STYLE_DEFAULT_TEXT}$battery_remaining_time_text${STYLE_CLEAR} | size=12"


if [ "$is_battery_charging" = "yes" ]; then prefix="${COLOUR_GREEN}$battery_level"; fi
if [ "$battery_level" -ge 100 ]; then prefix="${STYLE_CLEAR}${STYLE_DEFAULT_TEXT}$battery_level"; fi
if [ "$is_battery_charging" = "no" ]; then prefix="${COLOUR_RED}$battery_level"; fi

### </DisplayFormatting> ###


### <Output> ###

echo -e "${prefix}${suffix}"

echo "---"

echo "Cycle Count: ${cycle_count}"
echo "Wattage: ${wattage}"

### </Output> ###
