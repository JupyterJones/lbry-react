#!/bin/bash
# USEAGE:   mkfile_old MOVIEFILE DURATION_SECS
set -euo pipefail

# Paths

FFMPEG="/opt/ffmpeg/ffmpeg-2.8-64bit-static/ffmpeg"
WRK_DIR=$(pwd)

# Settings

FRAMERATE=10
PTS_RATIO=0.5
SIZE=640:480

# Listed as found on 2015-11-18 - try searching 'old film video overlay'
# YT_GRAIN_OVERLAY="https://www.youtube.com/watch?v=8hHsAI_gtKA"
# YT_GRAIN_OVERLAY="https://www.youtube.com/watch?v=Jm_SVOidsRI"
# YT_GRAIN_OVERLAY="https://www.youtube.com/watch?v=eAdqm-14QeU"
# YT_GRAIN_OVERLAY="https://www.youtube.com/watch?v=pJSZhNnVOn8"
# YT_GRAIN_OVERLAY="https://www.youtube.com/watch?v=72wlY5kerZ4"

YT_GRAIN_OVERLAY="https://www.youtube.com/watch?v=Y0QOpCwKyGI"

# Listed as found on 2015-11-18 - try searching 'vinyl noise' or 'vinyl effect'
# YT_NOISE_OVERLAY="https://www.youtube.com/watch?v=Q2Lcdi-LRws"
# YT_NOISE_OVERLAY="https://www.youtube.com/watch?v=EOY8pXNu-ew"

YT_NOISE_OVERLAY="https://www.youtube.com/watch?v=DQg9M_47c3A"

# Listed as found on 2015-11-18 - try searching 'old piano music saloon'
# YT_MUSIC_OVERLAY="http://www.youtube.com/watch?v=VnkBVCbNicg"
# YT_MUSIC_OVERLAY="http://www.youtube.com/watch?v=mfNxgdUEOF4"
# YT_MUSIC_OVERLAY="http://www.youtube.com/watch?v=wFEx_XMmcSs"
# YT_MUSIC_OVERLAY="http://www.youtube.com/watch?v=fPmruHc4S9Q"

YT_MUSIC_OVERLAY="http://www.youtube.com/watch?v=0SIizvT5Bk8"

# Arguments

SRC_FILE=${1:-}
DURATION=${2:-}

if [[ -z ${SRC_FILE} || -z ${DURATION} ]]
then
    echo "Usage: mkfilm_old VIDEO_FILE DURATION_SECS"
    exit -1
fi

if [[ ! -f ${SRC_FILE} ]]
then
    echo "Source file '${SRC_FILE}' doesn't exist"
    exit -1
fi

# Prepare

mkdir -p build

# Download resources

if [[ ! -f "build/yt_downloaded" ]]
then
    youtube-dl "$YT_GRAIN_OVERLAY" -f mp4 --output "build/grain.mp4"
    youtube-dl "$YT_NOISE_OVERLAY" -f mp4 --output "build/noise.mp4"
    youtube-dl "$YT_MUSIC_OVERLAY" -f mp4 --output "build/music.mp4"

    touch "build/yt_downloaded"
fi

# Extract audio with looping up to selected duration
$FFMPEG -f concat -i <(yes "file '${WRK_DIR}/build/noise.mp4'" | head -n 1000) -y -t ${DURATION} \
    -vn -f wav -ac 1 -ar 44100 "build/noise-ext.wav"
$FFMPEG -f concat -i <(yes "file '${WRK_DIR}/build/music.mp4'" | head -n 1000) -y -t ${DURATION} \
    -vn -f wav -ac 1 -ar 44100 "build/music-ext.wav"

# Normalize audio, fade-out and make "phone" audio effect with bandpass filter
sox "build/noise-ext.wav" "build/noise-eff.wav" bandpass 1000 500 norm -6 fade h 0:0 0 0:1
sox "build/music-ext.wav" "build/music-eff.wav" bandpass 1000 500 norm -2 fade h 0:0 0 0:1

# Mix music and noise
sox --combine mix "build/noise-eff.wav" "build/music-eff.wav" "build/audio.wav" gain -n -1

# Extract noise layer video with looping up to selected duration
$FFMPEG -f concat -i <(yes "file '${WRK_DIR}/build/grain.mp4'" | head -n 1000) -y -t ${DURATION} \
    -an -vf "scale=${SIZE}" -f mp4 -r ${FRAMERATE} -vcodec libx264 -pix_fmt yuv420p "build/grain-ext.mp4"

# Encoding source video
# https://ffmpeg.org/ffmpeg-filters.html

$FFMPEG \
    -y \
    -i "${SRC_FILE}" \
    -an \
    -vf "curves=preset=vintage, noise=alls=30:allf=t+u, colorchannelmixer=.3:.4:.3:0:.3:.4:.3:0:.3:.4:.3, setpts=${PTS_RATIO}*PTS, scale=${SIZE}" \
    -t ${DURATION} \
    -r ${FRAMERATE} \
    -f mp4 \
    -pix_fmt yuv420p \
    -vcodec libx264 \
    "build/video.mp4"

# Mix video with overlay

FADEOUT_S=$(( (DURATION - 2) * FRAMERATE))
FADEOUT_D=$(( 2 * FRAMERATE ))

$FFMPEG \
    -i "build/video.mp4" \
    -i "build/grain-ext.mp4" \
    -i "build/audio.wav" \
    -filter_complex "[1:v][0:v]blend=all_mode='hardlight', fade=type=out:start_frame=${FADEOUT_S}:nb_frames=${FADEOUT_D}[out]" \
    -map "[out]:v" -map "2:a" \
    -t ${DURATION} \
    -r ${FRAMERATE} \
    -f mp4 \
    -acodec mp3 \
    -ac 1 \
    -b:a 128k \
    -b:v 1m \
    -vcodec libx264 \
    -pix_fmt yuv420p \
    "output.mp4"