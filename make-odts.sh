#!/bin/sh
cd $(dirname $0)
for d in odt-*; do
  l=$(echo $d|sed 's/odt-\(.*\)/\1/')
  (
    cd $d
    zip -0 -r ../SalixLiveGuide-$l.odt *
  )
done
