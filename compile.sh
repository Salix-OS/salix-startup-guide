#!/bin/bash
cd $(dirname $0)

langask=$1
if [ "$2" = "pdf" ]; then
  pdf=yes
fi
for po in `ls po/*.po` po/en.po;do
  lang=$(echo $po|sed 's|po/\(.*\)\.po|\1|')
  if [[ -z "$langask" || "$langask" = "all" || (! -z "$langask" && "$langask" = "$lang") ]]; then
    echo "Compiling `echo $po|sed "s|po/||"`"
    name=SalixStartupGuide-$lang
    cp -r odt odt-$lang
    cp -L images/$lang/* odt-$lang/Pictures/
    find odt-$lang -name '.svn' -exec rm -rf '{}' \; 2>/dev/null
    (
      cd odt-$lang
      rm -f ../base-$lang.odt
      zip -r ../base-$lang.odt * >/dev/null
    )
    rm -rf odt-$lang
    if [ "$lang" != "en" ]; then
      echo "Merging new strings for locale “$lang”..."
      igettext-build.py base-$lang.odt $po -o $name.odt 2>&1
      rm base-$lang.odt
    else
      mv base-$lang.odt $name.odt
    fi
    if [ ! -z "$pdf" ]; then
      echo "Generating PDF locale “$lang”..."
      odt2pdf -vvv $name.odt
    fi
  fi
done
