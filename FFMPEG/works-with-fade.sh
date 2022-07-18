#!/bin/bash
ffmpeg -i JOINED.mkv -loop 1 -i text.png -filter_complex "[1:v]fade=t=in:st=10:d=5,fade=t=out:st=25:d=3[over];[0:v][over]overlay=0:0" \
-pix_fmt yuv420p -c:a copy -t 85 $1
