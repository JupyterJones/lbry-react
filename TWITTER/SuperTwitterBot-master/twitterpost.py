#!/anaconda2/bin/python
import os
import random
import sys
import markovify
import twython
from twython import Twython
import random
import time

# this is asleep prior to executing the status update. The intent is to break the rythym of posting exactly
# 15 minutes apart as executed by the bash script
SLEEP_INTERVAL = random.randint(90,200)
time.sleep(SLEEP_INTERVAL)

#removed keys for privacy reasons
CONSUMER_KEY = 'XXXXXXXXXXXXXXXX'
CONSUMER_SECRET = 'XXXXXXXXXXXXXXXX'
ACCESS_KEY = 'XXXXXXXXXXXXXXXX'
ACCESS_SECRET = 'XXXXXXXXXXXXXXXX'

twitter = Twython(CONSUMER_KEY, CONSUMER_SECRET, ACCESS_KEY, ACCESS_SECRET)
# notice the path begins with a slash but does NOT end with one
path = '/path/to/images'
count = 0
file_list = []
for filename in os.listdir(path):
        count = count+1
        file_list.append(filename)

rnd = random.randint(0,count)
with open("5000-8.txt") as f:
    text = f.read()
# Build the model.
text_model = markovify.Text(text)
# Print randomly-generated sentences of no more than 140 characters

#This line generates the markovify text and stores it in the vaiable STR
STR = (text_model.make_short_sentence(140))

# notice the path begins with a slash AND ends with one
#make sure the image directory has only images
photo = open('/Path/to/images/'+file_list[rnd],'rb')
response = twitter.upload_media(media=photo)
# status update is the variable STR generated above
twitter.update_status(status=STR, media_ids=[response['media_id']])