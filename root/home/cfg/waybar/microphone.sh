#!/bin/sh
# Shows audio information about the pulseaudio server

get_source_info() {
	return
}

printf '%s' "$sinkvolume / $sourcevolume"
