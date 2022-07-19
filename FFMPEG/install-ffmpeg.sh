#!/bin/bash
# remove comment below to download latest
cd /home
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
# --enable-gnutls \  --enable-libiec61883 \  --enable-libflite \  --enable-libopencv \  --enable-librsvg \
# --enable-libzmq \ 
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
 --prefix="$HOME/ffmpeg_build" \
 --pkg-config-flags="--static" \
 --extra-cflags="-I$HOME/ffmpeg_build/include" \
 --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
 --bindir="$HOME/bin" \
 --extra-version=0ubuntu0.16.04.1 \
 --build-suffix=-ffmpeg \
 --toolchain=hardened \
 --libdir=/usr/lib/x86_64-linux-gnu \
 --incdir=/usr/include/x86_64-linux-gnu \
 --enable-gpl \
 --cc=gcc \
 --cxx=g++ \
 --enable-cross-compile \
 --enable-version3 \
 --enable-shared \
 --disable-stripping \
 --disable-decoder=libopenjpeg \
 --enable-libbluray \
 --enable-libbs2b \
 --enable-libcaca \
 --enable-libcdio \
 --enable-libgme \
 --enable-libgsm \
 --enable-libmysofa \
 --enable-libopenmpt \
 --enable-librubberband \
 --enable-libshine \
 --enable-libssh \
 --enable-libtwolame \
 --enable-libxml2 \
 --enable-libzvbi  \
 --enable-openal \
 --enable-sdl2 \
 --enable-libdrm \
 --enable-ladspa \
 --enable-chromaprint  \
 --enable-avisynth \
 --enable-avresample \
 --enable-libass \
 --enable-libfontconfig \
 --enable-libfreetype \
 --enable-libfribidi \
 --enable-libmp3lame \
 --enable-libsnappy \
 --enable-libtheora \
 --enable-libvorbis \
 --enable-libvpx \
 --enable-libwavpack \
 --extra-cflags=-fPIC \
 --enable-libx265 \
 --enable-libxvid \
 --enable-opengl \
 --enable-libdc1394 \
 --enable-frei0r \
 --enable-libx264 \
 --enable-libpulse \
 --enable-indev=alsa \
 --enable-outdev=alsa \
 --enable-static \
 --disable-debug \
 --enable-libwebp \
 --enable-libspeex \
 --enable-fontconfig \
 --enable-libopencore-amrnb \
 --enable-libopencore-amrwb \
 --enable-libvo-amrwbenc \
 --enable-gray \
 --enable-libopenjpeg \
 --enable-libopus \
 --enable-libsoxr \
 --enable-libfribidi \
 --enable-libzimg \
 --disable-doc \
 --disable-programs \
 --enable-libtesseract


 #--enable-libvo-aacenc 

PATH="$HOME/bin:$PATH" make
make install
hash -r
