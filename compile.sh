#!/bin/sh

cd $(dirname $0)
for po in `ls po/*.po`;do
	echo "Compiling `echo $po|sed "s|po/||"`"
	igettext-build.py SalixStartupGuide-en.odt $po -o SalixStartupGuide-$(echo $po|sed 's|po/\(.*\)\.po|\1|').odt
done
