#!/bin/bash

# Run this file directly with:
# $ bash -c 'while [ 0 ]; do "./src/2-battery-status.18s.sh"; sleep 2; done'

# <bitbar.title>South Africa COVID-19 Lockdown Countdown</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc></bitbar.desc>

today=1587074400
time=$(($today - $(date +%s)))

printf '%dd:%dh:%dm:%ds\n' $(($time/60/60/24%365)) $(($time/3600%24)) $(($time%3600/60)) $(($time%60))
