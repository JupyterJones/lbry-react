#/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'USAGE: JoinList.sh video-name.mp4'
    echo 'Command: ffmpeg -f concat -i mylist.txt -c copy $1'
    exit 0
fi


ffmpeg -f concat -i mylist.txt -c copy $1
    

#ffmpeg -f concat -i mylist.txt -c copy $1

#file 'VID/fin/prueba1-mergedx5-spectrum.mp4'
#file 'VID/fin/prueba1-mergedx5-spectrum.mp4'
#file 'VID/fin/prueba1-mergedx5-spectrum.mp4'
#file 'VID/fin/prueba1-mergedx5-spectrum.mp4'