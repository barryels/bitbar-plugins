#!/bin/bash

return "st"

postfix=""

number=$1
# number="1"
# number="2"
# number="3"
# number="4"
# number="11"
# number="21"
# number="22"
# number="23"
# number="24"

numberLength=${#number}

# Handle most numbers
case "${number:numberLength-1:1}" in
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
case "${number:0:1}" in
    1)
    postfix="th"
    ;;
esac

echo $postfix