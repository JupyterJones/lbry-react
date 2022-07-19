ffmpeg -i images/mask.png -loop 1 -vf "movie=vids/1280x720.mp4[inner];[in][inner] overlay=0:0 [out]" -c:v libx264 -t 30 outputxxxxxxxxxx.mp4



ffmpeg -i vids/1280x720.mp4 -loop 1 -i images/mask.png -filter_complex \
"[0:v][1:v]alphamerge,hue=s=0,boxblur=5[fg]; \
 [0:v][fg]overlay[v]" -map "[v]" -map 0:a -c:a copy -t 30 boxbluroutput.mp4



ffmpeg -i vids/1280x720.mp4 -i film-overlay.png -filter_complex \
"[0:v][1:v] overlay=(W-w)/2:(H-h)/2:enable='between(t,0,30)'" \
-pix_fmt yuv420p -c:a copy -t 30 vids/film-overlay.mp4



ffmpeg -i opening.mkv -i episode.mkv -i ending.mkv \
  -filter_complex "[0:v] [0:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" \
  -map "[v]" -map "[a]" output.mkv


ffmpeg -i input1.mp4 -i input2.webm -i input3.mov \
-filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0][2:v:0][2:a:0]concat=n=3:v=1:a=1[outv][outa]" \
-map "[outv]" -map "[outa]" output.mkv


----------------- Good for mixed codecs --------------------------
ffmpeg -i intro.mkv -i part2.mkv \
-filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]" \
-map "[outv]" -map "[outa]" -t 30 bothoutput.mkv





/home/jack/Desktop/video-resources/temp/INTRO.mkv
/home/jack/Desktop/video-resources/temp/DSCF4270.mkv
ffmpeg -i INTRO.mkv -i DSCF4270.mkv \
  -filter_complex "[0:v] [0:a] [1:v] [1:a] concat=n=2:v=1:a=1 [v] [a]" \
  -map "[v]" -map "[a]" output.mkv

ONE IMAGE to VIDEO:
ffmpeg -loop 1 -i image.png -c:v libx264 -t 15 -pix_fmt yuv420p -vf scale=320:240 out.mp4
ffmpeg -loop 1 -i black1280x720.jpg -c:v libx264 -t 15 -pix_fmt yuv420p -vf scale=1280:720 black.mkv

ffmpeg -f lavfi -i color=s=800x600:d=10 -loop 1 -i allblackonwhite720.jpg -i audio.mp3 \
-filter_complex \
"[1:v]scale=-2:800[fg]; \
 [0:v][fg]overlay=x=-'t*w*0.1':shortest=1[v]" \
-map "[v]" -map 2:a output.mkv


ffmpeg -f lavfi -i color=s=800x600:d=10 -loop 1 -i allblackonwhite720.jpg \
-filter_complex \
"[1:v]scale=-2:800[fg]; \
 [0:v][fg]overlay=x=-'t*w*0.1':shortest=1[v]" \
-map "[v]" output.mkv

ffmpeg -f lavfi -i "color=color=black, drawtext=enable='gte(t,3)':fontfile=Vera.ttf:fontcolor=white:textfile=text.txt:reload=1:y=h-line_h-10:x=(W/tw)*n" \
-t 50 outputtext.mkv

ffmpeg -i black.mkv -filter_complex \
"[0]split[txt][orig];[txt]drawtext=fontfile=tahoma.ttf:fontsize=40:fontcolor=green:x=(w-text_w)/2+20:y=h-40*t:text="Line 1":bordercolor=white:borderw=2[txt]; \
[orig]crop=iw:50:0:0[orig];[txt][orig]overlay" -c:v libx264 -y -preset ultrafast line1.mp4

---------------------
0. Extract part of video from a larger file (it seems that is is the best to supply -ss and -t parameters with values in seconds):

ffmpeg -i original.f4v -ss 3262 -t 3115.5 -vcodec copy -acodec copy out.f4v

1. Shift audio forward by 25 ms (i.e. shift video 25 ms back compared to original file):
ffmpeg -i input_video.f4v -itsoffset 0.25 -i input_video.f4v -map 0:0 -map 1:1 -acodec copy -vcodec copy output_synchronized.f4v

2. Convert an image to desired resolution (in case it was originally exported to another resolution from Inkscape):
convert input_image.png -resize 1280x720 output_image.png

But actually I tend to export to the correct resolution directly from .svg..
3. Produce a 5 second title clip from an image file:
ffmpeg -loop 1 -i input_image.png -c:v libx264 -t 5 -pix_fmt yuv420p output_clip.mp4

4. Fade out effect on title clip:
ffmpeg -i title_clip.mp4 -y -vf fade=out:105:20 title_fade_out.mp4

5. Fade in effect on the video clip:
ffmpeg -i input_video.mp4 -strict experimental -y -vf fade=in:0:20 slide_fade_in.mp4

(the fade: parameter takes in/out:starting_frame:finishing_frame values)
(also, it seems to take a lot of time as it redecodes the whole file...)

5.5. Adding a silent audio to the autio stream:
ffmpeg -ar 48000 -ac 2 -f s16le -i /dev/zero -i video.mov -shortest -c:v copy -c:a aac -strict experimental output.mov

(according to http://stackoverflow.com/questions/12368151/adding-silent-audio-to-mov-in-ffmpeg)

6. Concatenating two video streams (both should have video and audio substreams...):
ffmpeg -i file_one.mp4 -i file_two.f4v -filter_complex '[0:0] [0:1] [1:0] [1:1] concat=n=2:v=1:a=1 [v] [a]' -map '[v]' -map '[a]' file_concatenated.f4v


7. If any of the stream does not have audio (e.g. produced from images as in 3), add audio stream to it:
ffmpeg -f lavfi -i aevalsrc=0 -i without_audio.mp4 -shortest -c:v copy -c:a mp3 -strict experimental with_audio.mp4
--------------


ffmpeg -i filipinas-dancing-laughing30.mp4 -i film-overlay.png \
-pix_fmt yuv420p -c:a copy -t 30 filipinas-dancing-laughing30F.mp4

ffmpeg -f concat -i list.txt -c copy Construction-update-Philippe-homes.mkv

------------good overlay
ffmpeg -i part1.mkv -itsoffset 5  -i  part1-overlay.mkv \
-filter_complex "[1:v] fade=in:st=0:d=1:alpha=1,fade=out:st=17:d=1:alpha=1,scale=620:360 [intro]; [0:v][intro] overlay [v]" \
-map "[v]" -map 0:a -acodec copy outzzzz5.mkv




ffmpeg -i part1.mkv -itsoffset 5  -i  part1-overlay.mkv \
-filter_complex "[1:v] fade=in:st=5:d=3:alpha=1,fade=out:st=17:d=1:alpha=1,scale=620:360 [intro]; \
[0:v][intro] overlay=1:x=50:y=50  [v]" \
-map "[v]" -map 0:a -acodec copy outzzzz7.mkv





ffmpeg -f concat -i list.txt -c copy 2500peso-rental.mkv

ffmpeg -i input.mp4 -vf drawtext="fontfile=/path/to/font.ttf: \
text='Stack Overflow': fontcolor=white: fontsize=24: box=1: boxcolor=black@0.5: \
boxborderw=5: x=(w-text_w)/2: y=(h-text_h)/2" -codec:a copy output.mp4

ffmpeg -i outzzzz8.mkv -vf  "drawtext=fontsize=60:fontcolor=white:fontfile=FreeSerif.ttf:text='Opps! 2,500 PHP':x=(w-text_w)/2:y=(h-text_h-line_h)/2, \
fade=in:st=14:d=3:alpha=1,fade=out:st=17:d=3:alpha=1" zzzoutput9.mp4

---------
ffmpeg -y -i outzzzz8.mkv -filter_complex "[0]split[base][text];[text]drawtext=fontfile=HelveticaNeue.ttf:text='Opps! 2,500 PHP': fontcolor=white: \
fontsize=40: box=1: boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2,format=yuva444p,fade=t=in:st=2:d=1:alpha=1,fade=t=out:st=3:d=1:alpha=1[subtitles]; \
[base][subtitles]overlay" outputoutzzzz8.mp4

-------------
stack exchange
ffmpeg -i input.mp4 -vf "format=yuv444p, \
 drawbox=y=ih/PHI:color=black@0.4:width=iw:height=48:t=fill, \
 drawtext=fontfile=OpenSans-Regular.ttf:text='Title of this Video':fontcolor=white:fontsize=24:x=(w-tw)/2:y=(h/PHI)+th, \
 format=yuv420p" -c:v libx264 -c:a copy -movflags +faststart output.mp4
________________
ffmpeg -y -i outzzzz8.mkv -filter_complex "[0]split[base][text];[text]drawtext=fontfile=HelveticaNeue.ttf:text='Opps! 2,500 PHP': fontcolor=white: \
fontsize=40: box=1: boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2,format=yuva444p,fade=t=in:st=20:d=2:alpha=1,fade=t=out:st=24:d=2:alpha=1[subtitles]; \
[base][subtitles]overlay" Ithinkthisisdone.mkv

________________

ffmpeg -i input.mp4 -loop 1 -i logo.png -filter_complex \
"[1]trim=0:30,fade=in:st=0:d=1:alpha=1,fade=out:st=9:d=1:alpha=1,loop=999:750:0,setpts=N/25/TB[w];\
[0][w]overlay=shortest=1:x=if(eq(mod(n\,200)\,0)\,sin(random(1))*w\,x):y=if(eq(mod(n\,200)\,0)\,sin(random(1))*h\,y)" output.mp4

ffmpeg -i input.mp4 -vf drawtext="fontsize=10:fontfile=/Windows/Fonts/arial.ttf:text='Text Here':x=if(eq(mod(n\,1200)\,0)\,rand(0\,(w-text_w))\,x):y=if(eq(mod(n\,1200)\,0)\,rand(0\,(h-text_h))\,y):enable=lt(mod(n\,1200)\,200)" \
-c:v libx264 -crf 17 -c:a copy output.mp4
  
ffmpeg -i input.avi -vf scale=320:240 output.avi

ffmpeg -i filipinas-dancing-laughing30.mp4 -i film-overlay.png \
-pix_fmt yuv420p -c:a copy -t 30 filipinas-dancing-laughing30F.mp4
---------------------works
ffmpeg -i part1.mkv -itsoffset 5  -i  part1-overlay.mkv \
-filter_complex "[1:v] fade=in:st=0:d=1:alpha=1,fade=out:st=17:d=1:alpha=1, scale=620x360 [intro]; \
[0:v][intro] overlay=1:x=700:y=300 [v]" \
-map "[v]" -map 0:a -acodec copy -s 1280x720 -framerate 17 -c:v libx264 -t 40 outzzzz40.mkv



ffmpeg -i part1.mkv -i part1-overlay.mkv -threads 0 \
-filter_complex "nullsrc=size=1280x720 [base]; \
[0:v] setpts=PTS-STARTPTS, scale=1280x720  [upperleft]; \
[1:v] setpts=PTS-STARTPTS, scale=620x3680 [lowerright]; \
[base][upperleft] overlay=shortest=1 [tmp1]; \
[tmp1][lowerright] overlay=shortest=1:x=700:y=300" \
-s 1280x720 -framerate 17 -c:v libx264 part1-with-overlay.mkv

ffmpeg -i part1.mkv -i part1-overlay.mkv -threads 0 \
-filter_complex "nullsrc=size=1280x720 [base]; \
[0:v] setpts=PTS-STARTPTS, scale=1280x720  [upperleft]; \
[1:v] setpts=PTS-STARTPTS, scale=620x3680 [lowerright]; \
[base][upperleft] overlay=shortest=1 [tmp1]; \
[tmp1][lowerright] overlay=shortest=1:x=700:y=300" \
-s 1280x720 -framerate 17 -c:v libx264 part1-with-overlay.mkv


ffmpeg -i part1.mkv -i part1-overlay.mkv -threads 0 \
-filter_complex "nullsrc=size=1280x720 [base]; \
[0:v] setpts=PTS-STARTPTS, scale=1280x720  [upperleft]; \
[1:v] setpts=PTS-STARTPTS, scale=620x360 [lowerright]; \
[base][upperleft] overlay=shortest=1 [tmp1]; \
[tmp1][lowerright] overlay=shortest=1:x=700:y=300" \
-s 1280x720 -framerate 17 -c:v libx264 part1-with-overlay.mkv



ffmpeg -itsoffset 5 -i in.mp4 -r 30 -loop 1 -i intro.png \
-filter_complex "[1:v] fade=out:125:25:alpha=1 [intro]; [0:v][intro] overlay [v]" \
-map "[v]" -map 0:a -acodec copy out.mp4



ffmpeg -i vids/1280x720.mp4 -i film-overlay.png -filter_complex \
"[0:v][1:v] overlay=(W-w)/2:(H-h)/2:enable='between(t,0,156)'" \
-pix_fmt yuv420p -c:a copy vids/video-film-frame.mp4

ffmpeg -i $1 -i film-overlay.png -filter_complex \
"[0:v][1:v] overlay=(W-w)/2:(H-h)/2:enable='between(t,0,156)'" \
-pix_fmt yuv420p -c:a copy $2

ffmpeg -y -i vids/store.mp4 -loop 1 -t 1 -i images/mask.png \
-filter_complex \
"color=black:d=1[c];[c][0]scale2ref[cs][v];[cs]setsar=1[ct]; \
[1:v]alphaextract,negate[m];[m][ct]scale2ref[ms][ol];[ms]setsar=1[alf]; \
[ol][alf]alphamerge[fin]; \
[v][fin]overlay,scale‌​=640:1136:force_orig‌​inal_aspect_ratio=de‌​crease[fv]; \
[fv]pad=6‌​40:1136:(ow-iw)/2:(o‌​h-ih)/2:#000000@1[v]‌​" \
-map "[v]" -map 0:a vids/maskedoutput.mp4

--------- GOOD STUFF -----------
ffmpeg -i Make-a-Video-Using-Javascript.mkv -i  Fish-cropped.mkv \
-filter_complex "[1:v] fade=in:st=50:d=3:alpha=1,fade=out:st=124:d=3:alpha=1,scale=380:380 [intro]; \
[0:v][intro] overlay=1:x=20:y=20:enable='between(t,50,127)' [v]" -map "[v]" -map 0:a \
-acodec copy make-fish-crop005.mkv

ffmpeg -loop 1 -t 5 -i JavaScript-Animation-Passing-time-in-Philippines.jpg \
-loop 1 -t 5 -i JavaScript-Animation-Passing-time-in-Philippines.jpg \
-f lavfi -t 5 -i anullsrc -i JavaScript-Animation-Passing-time-in-Philippines.mkv \
-filter_complex "[2:a]asplit[i][e]; \
[0]fade=in:st=0:d=1[0f]; \
[1]fade=out:st=4:d=1[1f]; \
[0f][i][3:v][3:a][1f][e]concat=n=3:v=1:a=1[v][a]" \
-map [v] -map [a] output2.mp4


ffmpeg -loop 1 -t 5 -i /home/jack/Desktop/video-resources/TEMP/Filipino-Birthday-Party-Happy-50th-Oscar-1of2.jpg \
-loop 1 -t 5 -i /home/jack/Desktop/video-resources/TEMP/Filipino-Birthday-Party-Happy-50th-Oscar-1of2.jpg \
-f lavfi -t 5 -i anullsrc -i /home/jack/Desktop/video-resources/TEMP/Filipino-Birthday-Party-Happy-50th-Oscar-1of2.mkv \
-filter_complex "[2:a]asplit[i][e]; \
[0]fade=in:st=0:d=1[0f]; \
[1]fade=out:st=4:d=1[1f]; \
[0f][i][3:v][3:a][1f][e]concat=n=3:v=1:a=1[v][a]" \
-map [v] -map [a] output1.mp4






ffmpeg -i JavaScript-Animation-Passing-time-in-Philippines.mkv -i JavaScript-Animation-Passing-time-in-Philippines.jpg \
-filter_complex "[0:v][1:v] overlay=0:0:fade=in:0:d=0 fade=out:3:d=3" -pix_fmt yuv420p -c:a TEST002.mkv


ffmpeg -i make-fish-crop005.mkv -i JavaScript-Animation-Passing-time-in-Philippines.jpg \
-filter_complex "[0:v][1:v] fade=out:st=0:d=3:alpha=1, overlay=0:0:enable='between(t,0,3)'" -pix_fmt yuv420p -c:a copy out.mp4

ffmpeg -i make-fish-crop005.mkv -i JavaScript-Animation-Passing-time-in-Philippines.jpg \
-filter_complex "[0:v][1:v] overlay=0:0:enable='between(t,0,2)'" -pix_fmt yuv420p -c:a copy output.mp4

ffmpeg -i make-fish-crop005.mkv -framerate 30000/1001 -loop 1 -i JavaScript-Animation-Passing-time-in-Philippines.jpg \
-filter_complex "[1:v] fade=out:3:d=3 [ov]; [0:v][ov] overlay=0:0 [v]" -map "[v]" -map \
-c:v -c:a copy intro-over.mp4 

fmpeg -i make-fish-crop005.mkv -i JavaScript-Animation-Passing-time-in-Philippines.jpg \
-filter_complex "[0:v][1:v] overlay=0:0:enable='between(t,0,5)',fade=t=in:st=0:d=4, fade=t=out:st=5:d=2'" -c:v libx264 -crf 23 output1212.mp4 


ffmpeg -i LOGO.mp4 -i VIDEO.mp4 
-filter_complex "[1][0]scale2ref=iw/2:-2[scaled][ref]; 
[ref][scaled]overlay=x=0:y=0[composite]" 
-map [composite] 
-y OUTPUT.mp4

ffmpeg -i Bings-store.mp4 -i vids/250square.mp4 \
-filter_complex "[1][0]scale2ref=iw/2:-2[scaled][ref];  \
[ref][scaled]overlay=x=0:y=0[composite]" \
-map [composite] \
-y 250square.mp4 \

ffmpeg -y -i vids/1280x720.mp4 -loop 1 -t 1 -i images/mask.png  \
 -filter_complex \
      "color=black:d=1[c];[c][0]scale2ref[cs][v];[cs]setsar=1[ct]; \
       [1:v]alphaextract,negate[m];[m][ct]scale2ref[ms][ol];[ms]setsar=1[alf]; \
       [ol][alf]alphamerge[fin]; \
       [v][fin]overlay,scale‌​=1280:720:force_orig‌​inal_aspect_ratio=de‌​crease[fv]; \
       [fv]pad=1280:720:(ow-iw)/2:(o‌​h-ih)/2:#000000@1[v]‌​" \
-map "[v]" -map 0:a output.mp4

--------------- best lightness brightness control -------------------
You can use simple filtergraphs easily with ffplay.
Example using colorlevels filter in ffplay:
ffplay -vf colorlevels=rimax=0.902:gimax=0.902:bimax=0.902 input.mp4

Then you can use the same filter in ffmpeg:
ffmpeg -i runall.mp4 -vf colorlevels=rimax=0.902:gimax=0.902:bimax=0.902 -c:a copy colorlevelsrunalllighter1.mkv


ffmpeg -i part1.mkv -i part1-overlay.mkv \
-filter_complex "nullsrc=size=1280x720 [base]; 
[0:v] setpts=PTS-STARTPTS, scale=1280x720  [upperleft];  
[1:v] setpts=PTS-STARTPTS, scale=320x180 [lowerright]; 
[base][upperleft] overlay=shortest=1 [tmp1]; 
[tmp1][lowerright] overlay=shortest=1:x=700:y=300" 
-s 1280x720 -framerate 17 -c:v libx264 part1-overlaid.mp4

ffmpeg -i video1.avi -i video2.avi -filter complex “[0:v:0] [0:a:0] [1:v:0] [1:a:0] concat=n=2:v=1:a=1 [v] [a]” -map “[v]” -map “[a]” output_video.avi

------------- This did not work ---------
ffmpeg -i outputlighter.mp4 -vf curves=preset=lighter -c:a copy outputlighter2.mp4
The red, green, and blue colors may be adjusted separately. curves=r='0.4/0.5':g='0.4/0.5':b='0.4/0.5'
ffmpeg -i runall.mp4 -vf curves=r='0.4/0.5':g='0.4/0.5':b='0.4/0.5' -c:a copy runalllighter1.mkv
-------------------

------------------ what is color range ?
You may see an improvement if you add 
-x264opts colormatrix=bt709 and remove 
-vf format=yuvj420p -color_range 2

ffmpeg -i input.mkv -filter:v "setpts=0.5*PTS" output.mkv


ffplay -filter:v "setpts=0.5*PTS"



ffmpeg -i vids/1280x720.mp4 -vf "movie='images/mask.png',alphaextract[a];[in][a]alphamerge" -c:v qtrle maskedoutput.mov

ffmpeg -y -i vids/1280x720.mp4 -loop 1 -i images/mask.png -filter_complex "[1:v]alphaextract[alf];[0:v][alf]alphamerge" -c:v qtrle -an maskedoutput.mp4

Capture without audio

 ffmpeg -f x11grab -r 25 -s 1280x720 -i :0.0+0,24 -vcodec libx264 -vpre lossless_ultrafast -threads 0 video.mkv

Compress and convert to MP4 format (Youtube ready):

 ffmpeg -i video.mkv -vcodec libx264 -vpre hq -crf 22 -threads 0 video.mp4

Lower -crf may give higher quality but for screen captures the improvement is only marginal. For post processing in iMovie or Final Cut Express better to use .mov container in the above conversion.

If ffmpeg complains that it has no hq preset, then try some of the others. Look for .ffpreset files in /usr/share/ffmpeg/. I had good success with -vpre medium (actually it might be the same as hq used to be).
Capturing with audio

 ffmpeg -f alsa -i pulse -f x11grab -r 25 -s 1280x720 -i :0.0+0,24 -acodec pcm_s16le 
   -vcodec libx264 -vpre lossless_ultrafast -threads 0 output.mkv

TODO:
The audio output can also be captured with gstreamer:

gst-launch-1.0 -e pulsesrc device="alsa_input.pci-0000_00_14.2.analog-stereo" ! audioconvert ! \
lamemp3enc target=1 bitrate=128 cbr=true ! filesink location=output.mp3

where the device name is the one returned by:

 pactl list | grep -A2 'Source #' | grep 'Name: ' | cut -d" " -f2
>> alsa_output.usb-Logitech_Inc._Logitech_USB_Headset_H340-00.analog-stereo.monitor
>> alsa_input.usb-Logitech_Inc._Logitech_USB_Headset_H340-00.iec958-stereo
>> alsa_output.pci-0000_00_14.2.iec958-stereo.monitor
>> alsa_input.pci-0000_00_14.2.analog-stereo

1. Screecasting

To record your screen withh FFMPEG, you can use this command:

ffmpeg -f x11grab -follow_mouse 100 -r 25 -s vga -i :0.0 filename.avi

Now the command will record every spot on your screen you hover your mouse cursor over. Press Ctrl+C to stop recording. If you want to set a screen resolution for the video to be recorded, you can use this ffmpeg command:

ffmpeg -f x11grab -s 800x600 -r 25 -i :0.0 -qscale 5 filename.avi  

To show the region that will be recorded while moving your mouse pointer, use this command:
ffmpeg -f x11grab -follow_mouse centered -show_region 1 -r 25 -s vga -i :0.0 filename.avi
 do not show marker ffmpeg -f x11grab -follow_mouse centered -show_region 0 -r 25 -s vga -i :0.0 filename.avi
If you want to record in fullscreen with better video quality (HD), you can use this command:

ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq  video.mp4
Here is a video example created with the latter command:

2. Add Audio To A Static Picture
If you want to add music to a static picture with ffmpeg, run this command from the terminal: dsd

ffmpeg -i audio.mp3 -loop_input -f image2 -i file.jpg -t 188 output.mp4

3. Add Image Watermarks to A Video
To add an image to a video using ffmpeg, you can use one of these commands:
Picture Location: Top Left Corner

ffmpeg -i input.avi -vf "movie=file.png [watermark]; [in][watermark] overlay=10:10 [out]" output.flv

Here is an example:
Picture Location: Top Right Corner

ffmpeg –i input.avi -vf "movie=watermarklogo.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:10 [out]" output.flv

Picture Location: Bottom Left Corner

ffmpeg –i input.avi -vf "movie=watermarklogo.png [watermark]; [in][watermark] overlay=10:main_h-overlay_h-10 [out]" output.flv

Picture Location: Bottom Right Corner

ffmpeg –i input.avi -vf "movie=watermarklogo.png [watermark]; [in][watermark] overlay=main_w-overlay_w-10:main_h-overlay_h-10 [out]" output.flv

4. Add Text Watermarks To Videos
To add text to a video, use this command:

ffmpeg -i input.mp4 -vf drawtext="fontfile=/usr/share/fonts/truetype/freefont/FreeSans.ttf: text='YOUR TEXT HERE':fontcolor=red@1.0:fontsize=70:x=00: y=40" \
-y output.mp4

An example:
To use another text font, you can list them from the terminal with this command:
ls /usr/share/fonts/truetype/freefont/

4. Rotate Videos
To rotate a video 90 degrees with ffmpeg, run this command:

ffmpeg -i input.avi -vf transpose=1 output.avi

Here is an example for a video rotated with ffmpeg:


Here is all parameters:

    0 = 90 degrees CounterCLockwise  (Vertical Flip (default))
    1 = 90 degrees Clockwise
    2 = 90 degrees CounterClockwise
    3 = 90 degrees Clockwise (Vertical Flip)


5. Adjust Audio/Video Volume
You can use ffmpeg to change volume of a video file with this command:

ffmpeg -i input.avi -vol 100  output.avi

To change volume of an audio file, run this command:

ffmpeg -i input.mp3 -vol 100 -ab 128 output.mp3

6. Insert A Video Inside Another Video
To do this, run this command:

ffmpeg -i video1.mp4 -vf "movie=video2.mp4:seek_point=5, scale=200:-1, setpts=PTS-STARTPTS [movie]; [in] setpts=PTS-STARTPTS, [movie] overlay=270:240 [out]" output.mp4

Here is an example:
7. Add a Rectangle To A Video
To draw for example an orange rectangle in a video, you can use this command:

ffmpeg -i input.avi -vf "drawbox=500:150:600:400:orange@0.9" -sameq -y output.avi

#!/bin/bash
ffmpeg -i 2019-01-30-10-45.mp4 -an -ss 36 -t 120 thefishcut01.mkv
430x430:296:215
760x430        132,213
ffmpeg -i thefishcut01.mkv -filter:v "crop=760:430:132:215" -vf scale="760:430" Fish-cropped-1280x720.mp4
ffmpeg -i FinalFish.mp4 -filter:v "crop=1024:1141:0:465" Fishout2.mp4


ffmpeg -i in.mp4 -filter:v "crop=out_w:out_h:x:y" out.mp4



ffmpeg -i thefishcut01.mkv -filter:v "crop=760:430:132:215" Fish-cropped.mp4

----good with no fade ===============
ffmpeg -i Make-a-Video-Using-Javascript.mkv -i Fish-cropped2.mkv -filter_complex \
"[0:v][1:v] overlay=700:300:enable='between(t,30,105)'" \
-pix_fmt yuv420p -c:a copy make-a video-overlad.mkv

NO GOOD
ffmpeg -i Make-a-Video-Using-Javascript.mkv -i Fish-cropped.mkv -filter_complex \
"[0:v][1:v] overlay=20:20:enable='between(t,30,105),fade=in:st=30:d=1:alpha=1,fade=out:st=103:d=2:alpha=1,'" \
-pix_fmt yuv420p -c:a copy make-video-overlad.mkv


ffmpeg -i Make-a-Video-Using-Javascript.mkv -i Fish-cropped.mkv -filter_complex \
"[0:v][1:v] fade=in:st=30:d=2:alpha=1,fade=out:st=103:d=3:alpha=1,'" \
-pix_fmt yuv420p -c:a copy make-a video-overlad-fade.mkv

ffmpeg -i part1.mkv -itsoffset 5  -i  part1-overlay.mkv \
-filter_complex "[1:v] fade=in:st=60:d=3:alpha=1,fade=out:st=168:d=2:alpha=1,scale=620:360 [intro]; \
[0:v][intro] overlay=1:x=10:y=10  [v]" \
-map "[v]" -map 0:a -acodec copy outzzzz7.mkv

ffmpeg -i Make-a-Video-Using-Javascript.mkv -i  Fish-cropped.mkv \
-filter_complex "[1:v] fade=in:st=25:d=3:alpha=1,fade=out:st=98:d=2:alpha=1,scale=380:380 [intro]; \
[0:v][intro] overlay=1:x=20:y=20  [v]" \
-map "[v]" -map 0:a -acodec copy maybefinal.mkv


ffmpeg -i Make-a-Video-Using-Javascript.mkv -i  Fish-cropped.mkv \
-filter_complex "[1:v] fade=in:st=55:d=3:alpha=1,fade=out:st=130:d=2:alpha=1,scale=380:380 [intro]; \
[0:v][intro] overlay=1:x=20:y=20  [v]" -map "[v]" -map 0:a -acodec copy maybefinal.mkv

ffmpeg -i part1.mkv -itsoffset 5  -i  part1-overlay.mkv \
-filter_complex "[1:v] fade=in:st=0:d=1:alpha=1,fade=out:st=17:d=1:alpha=1,scale=620:360 [intro]; [0:v][intro] overlay [v]" \
-map "[v]" -map 0:a -acodec copy outzzzz5.mkv

ffmpeg -i Make-a-Video-Using-Javascript.mkv -i  Fish-cropped3.mkv -filter_complex "[1:v] fade=in:st=5:d=3:alpha=1,fade=out:st=17:d=1:alpha=1,scale=380:380 [intro]; \
[0:v][intro] overlay=1:x=850:y=10  [v]" -map "[v]" -map 0:a -acodec copy make-fish-crop001.mkv

ffmpeg -i Make-a-Video-Using-Javascript.mkv -i  Fish-cropped.mkv \
-filter_complex "[1:v] fade=in:st=50:d=3:alpha=1,fade=out:st=124:d=3:alpha=1,scale=380:380 [intro]; \
[0:v][intro] overlay=1:x=20:y=20 [v]" \
-map "[v]" -map 0:a -acodec copy make-fish-crop002.mkv


enable='between(t,50,126)









30 75

ffmpeg -i Make-a-Video-Using-Javascript.mkv -i Fish-cropped2.mp4 \
-filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]" \
-map "[outv]" -map "[outa]" -t 30 bothoutput.mkv

#!/bin/bash

for file in *.png
do
   date=\$(date +%Y%m%d)
   basename=\${file%.*}    # Remove extension
   extension=\${file##*.}  # Remove basename
   ffmpeg -i \$file -vf scale=720:-1 -y TEMP.jpg
   ffmpeg -i TEMP.jpg -vf  \"crop=720:720:0:0\" -y \"\$basename\"_\"\$date.\$extension\"

done
