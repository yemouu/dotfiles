#!/bin/sh
# shellcheck disable=SC2034

## general ##
# defines were screenshots and recordings will be stored 
scr_basedir="${HOME}/tmp/scr"
scr_pic_dir="${scr_basedir}/pic"
scr_rec_dir="${scr_basedir}/rec"
scr_aud_dir="${scr_basedir}/aud"

## aud settings ##
# Audio devices to use for recording audio.
# These devices canbe found by executing `pactl list sinks | grep "Monitor Source"`
# for the sink and by executing `pactl list sources | grep Name:` for the source.
aud_sink="$(pactl info | grep Default\ Sink)"
aud_sink="${aud_sink#Default\ Sink: }.monitor"
aud_source="$(pactl info | grep Default\ Source)"
aud_source="${aud_source#Default\ Source: }"

# The name of the audio file.
aud_filename="$(date +%y-%m-%d-%H_%M_%S).wav"

## pic settings ##
# The name of the image file.
pic_filename="$(date +%y-%m-%d-%H_%M_%S).png"

## rec settings ##
# The name of the video file.
rec_filename="$(date +%y-%m-%d-%H_%M_%S).mp4"
# extra flags for wf-recorder
rec_extraflags="-t -c h264_vaapi -d /dev/dri/renderD128"
