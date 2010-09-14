#!/bin/sh
cd $(dirname "$0")/images
for f in $(svn st */*.* | grep '^~' | gawk '{print $2}'); do
  mt=$(file --mime-type -b "$f")
  if [ "$mt" = "application/x-symlink" ]; then
    svn pd svn:mimetype "$f"
    svn ps svn:special '*' "$f"
  else
    svn pd svn:special "$f"
    svn ps svn:mimetype "$mt" "$f"
  fi
done
for f in */*.*; do
  mt=$(file --mime-type -b "$f")
  if [ ! "$mt" = "application/x-symlink" ]; then
    if [ ! "$mt" = "$(svn pg svn:mimetype $f)" ]; then
      svn ps svn:mimetype "$mt" "$f"
    fi
  fi
done
