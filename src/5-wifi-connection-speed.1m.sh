#!/bin/bash

# Run this file directly with:
# $ bash -c 'while [ 0 ]; do "./src/FILENAME.sh"; sleep 2; done'

# <bitbar.title>WiFi Link Speed</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Displays WiFi connection speed (Link speed) in Mbps.</bitbar.desc>
# <bitbar.image>https://barryels.github.io/bitbar-plugins/src/battery-status/image.png</bitbar.image>

COLOUR_RED='\033[0;31m'
COLOUR_GREEN='\033[0;32m'
COLOUR_LIGHT_GRAY='\033[0;37m'

STYLE_CLEAR='\033[0m'
STYLE_DEFAULT_TEXT=$COLOUR_LIGHT_GRAY


wifi_link_speed=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep lastTxRate: | sed 's/.*: //')

prefix="${STYLE_DEFAULT_TEXT}$wifi_link_speed$suffix"
suffix="${STYLE_CLEAR} | size=12"

if [ "$wifi_link_speed" -lt "200" ]; then prefix="${COLOUR_RED}$wifi_link_speed$suffix"; fi

echo -e "${prefix}${suffix}"
