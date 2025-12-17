#!/bin/bash
# Easy Level Script 8: Time-based Greeting
# Display greeting based on time of day

hour=$(date +%H)

if [ $hour -lt 12 ]; then
    greeting="Good Morning"
elif [ $hour -lt 18 ]; then
    greeting="Good Afternoon"
else
    greeting="Good Evening"
fi

echo "$greeting! Current time is $(date +%H:%M)"

