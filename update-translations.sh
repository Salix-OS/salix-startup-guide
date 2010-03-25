#!/bin/sh

cd $(dirname $0)
igettext-extract.py SalixStartupGuide-en.odt > po/SalixStartupGuide.pot

cd po
for i in `ls *.po`; do
	msgmerge -U $i SalixStartupGuide.pot
done
rm -f ./*~
