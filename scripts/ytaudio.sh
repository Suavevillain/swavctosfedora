#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: ./ytaudio.sh <YouTube URL>"
  exit 1
fi

URL="$1"

yt-dlp \
  -f bestaudio \
  --extract-audio \
  --audio-format mp3 \
  --audio-quality 320K \
  --embed-metadata \
  --embed-thumbnail \
  --add-metadata \
  --parse-metadata "%(uploader)s:%(artist)s" \
  -o "%(title)s.%(ext)s" \
  "$URL"

echo "Done."
