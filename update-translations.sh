#!/bin/sh
cd $(dirname $0)

cp images/en/* odt/Pictures/
(
  cd odt
  zip -r ../SalixStartupGuide-en.odt * >/dev/null
)
igettext-extract.py SalixStartupGuide-en.odt > po/SalixStartupGuide.pot
rm SalixStartupGuide-en.odt
cd po
for i in `ls *.po`; do
	msgmerge -U $i SalixStartupGuide.pot
done
rm -f ./*~
