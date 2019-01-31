#!/bin/bash

postfix=""

number=$1

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

# Handle numbers in the 10 to 19 range
if [ "$numberLength" -gt 1 ]; then
    case "${number:0:1}" in
        1)
        postfix="th"
        ;;
    esac
fi

echo $postfix