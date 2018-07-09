#!/bin/bash

title="Nearly There"
message="5 minutes to go"

# title="Job's Done"
# message="Set another timer?"

osascript -e "display notification \"$message\" with title \"$title\""
