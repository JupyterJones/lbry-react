Introduction
============
This document contains some of the ffmpeg snippets I use most commonly, and typically in the context of converting research-related image data to video. It is not meant to be exhaustive.

Further reading
===============
* Documentation: https://ffmpeg.org/ffmpeg.html
* Superuser community: https://superuser.com/questions/tagged/ffmpeg
* More on concatenation / named pipes: https://trac.ffmpeg.org/wiki/Concatenate
* A tutorial: [Learn FFmpeg libav the Hard Way](https://github.com/leandromoreira/ffmpeg-libav-tutorial#learn-ffmpeg-libav-the-hard-way)


Common parameters
=================
* Add input: `-i <file(s)>`, example: `-i color-%01d.png` 
* Add input alphabetically: `-pattern_type glob -i '*.png'`
* Set start frame (before -i):  `-start_number <number>`
* Limit frames: `-vframes <number>`
* Overwrite without asking: `-y` (contraty to `-n`)
* Set ouput codec video/audio: `-c:v` == `-codec:v` == `-vcodec` / `-a:v` == `-codec:a` == `-acodec`
* Set bitrate video/audio: `-b:v <rate>` / `-b:a <rate>`, examples: `-b:v 1400K`, `-b:v 1M`
* Set offset between keyframes: `-g <offset>`
* Use video/audio filter: `-vf` == `-filter:v`  /  `-af` == `-filter:a`  
* Set framerate (before input / output to pick target): `-r <number>`
* Format (input/output): `-f <fmt>`, (use `-f lavfi` to use filter as input)
* Constant Rate Factor (h264,h265): `-crf` (range: 0–51, 0=lossless, 23=default(h264), 28=default(h265), 51=worst)

Common filters
==============
* D->RGB:       `[in]format=pix_fmts=rgb24[out]`: convert greyscale to rgb (required for stacking)
* Crop:         `[in]crop=<w>:<h>:<x>:<y>[out]`
* Scale:        `[in]scale=<w>:<h>[out]`
* Stack:        `[left][right]hstack[out]`, `[top][bottom]vstack[out]`
* Vary speed:   `[in]setpts=0.5*PTS[out]`: (remember to half the value of 'vframes', if set), (2x speed, here)
* Textbox:      `drawtext=fontfile=<ttf>: text='<text>': fontcolor=<color>: fontsize=<size>: box=1: boxcolor=<color>: boxborderw=<w>: x=<x>: y=<y>`
* Concat:       `ffmpeg -i 1.mp4 2.mp4 3.mp4 4.mp4 -filter_complex "concat=n=4:v=1:a=0"`
* Width and height divisible by 2: `pad=ceil(iw/2)*2:ceil(ih/2)*2`

Common formats
==============
* For web (more compatible): `ffmpeg -i <in>.mp4 -c:v libx264 -crf 23 -profile:v baseline -level 3.0 -pix_fmt yuv420p -movflags faststart <out>.mp4`
* For web (less compatible): `ffmpeg -i <in>.mp4 -c:a libvorbis -c:v libvpx-vp9 -b:v 1400K -g 120 out.webm`
* For PC: `ffmpeg -i in.mp4 -c:a libvorbis -c:v libx264 -crf 32 <out>.mp4`
* Better decoder support with: `-profile:v high -pix_fmt yuv420p -movflags faststart`

Examples / techniques
=====================

Set background color
--------------------
Use additional input `-f lavfi -i color=c=white:s=<w>x<h>` and overlay with it `[bg][fg]overlay=shortest=1`.
You might want to keep the scale of a specific input instead of setting `<w>` and `<h>` for the background: `[bg][fg]scale2ref[bg][fg]`

Remove part of video
--------------------
Use trim filter `[0:v]trim=duration=8[a]` get video until second 8,
`[0:v]trim=start=16,setpts=PTS-STARTPTS[b]` get video from second 16 to end (otherwise use end=..),
finally, concat results "[a][b]concat"
See: https://superuser.com/questions/681885/how-can-i-remove-multiple-segments-from-a-video-using-ffmpeg

Fade transition of videos
-------------------------
```
ffmpeg \
-i a.mp4 \
-i b.mp4 \
-filter_complex " \
  color=white:1280x960,fade=out:st=4:d=1[alpha_a]; \
  [0:v][alpha_a]alphamerge[overlay_a]; \
  [1:v][overlay_a]overlay=0:0" out.mp4
```

Stacking videos with textboxes
------------------------------
```
ffmpeg \
-i a%01d.png \
-i b%01d.png \
-filter_complex "hstack=inputs=2, \
  drawtext=fontfile=/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-R.ttf: text='3D labeled': fontcolor=white: fontsize=32: box=1: boxcolor=black@0.6: boxborderw=5: x=100: y=5, \
  drawtext=fontfile=/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-R.ttf: text='3D colored': fontcolor=white: fontsize=32: box=1: boxcolor=black@0.6: boxborderw=5: x=1060: y=5" \
-vcodec libx264 out.mp4
```

Extract all frames of video as jpg
----------------------------------
```
# highest quality:
ffmpeg -i <video>.mp4 -qmin 1 -qmax 1 -q:v 1 %06d.jpg
# q normally ranges from 2-31, and it is more typical to use:
ffmpeg -i <video>.mp4 -q:v 2 %06d.jpg
```

Pipe to ffplay
--------------
```
ffmpeg -f lavfi -i testsrc -f matroska - | ffplay -
```