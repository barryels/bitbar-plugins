#!/usr/bin/python
# coding=utf-8
# 
# <bitbar.title>Circle CI Recent Builds</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Barry Els</bitbar.author>
# <bitbar.author.github>barryels</bitbar.author.github>
# <bitbar.desc>Displays a some data about your recent Circle CI builds.</bitbar.desc>
# <bitbar.image>http://i.imgur.com/h2cyuYu.png</bitbar.image>


import os
import json


SCRIPT_DIR = os.path.dirname(__file__)
ENV_FILE_PATH = os.path.join(SCRIPT_DIR, "./.env")


env_config_file_lines = open(ENV_FILE_PATH).read().splitlines()


CIRCLE_CI_API_KEY = env_config_file_lines[0].split("CIRCLE_CI_API_KEY=")[1]


url = "https://circleci.com/api/v1.1/recent-builds?circle-token=" + CIRCLE_CI_API_KEY
result = os.popen("curl --silent -X GET " + url).read()
json_object = json.loads(result)


print "Circle CI Stats | size=12"


print "---"
print "Last 30 builds:"
print "\n"

for item in json_object:
  print(str(item['build_num']) + ": " + str(item['status']))

print "---"
