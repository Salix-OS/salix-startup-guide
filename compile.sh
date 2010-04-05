#!/bin/bash
cd $(dirname $0)

langask=$1
for po in `ls po/*.po`;do
  lang=$(echo $po|sed 's|po/\(.*\)\.po|\1|')
  if [[ -z "$langask" || (! -z "$langask" && "$langask" = "$lang") ]]; then
    echo "Compiling `echo $po|sed "s|po/||"`"
    name=SalixStartupGuide-$lang
    cp -r odt odt-$lang
    cp -L images/$lang/* odt-$lang/Pictures/
    find odt-$lang -name '.svn' -exec rm -f '{}' \; 2>/dev/null
    (
      cd odt-$lang
      zip -r ../base-$lang.odt * >/dev/null
    )
    rm -rf odt-$lang
    echo "Merging new strings for locale “$lang”..."
    igettext-build.py base-$lang.odt $po -o $name.odt 2>&1 | grep -v -A1 'DeprecationWarning'
    rm base-$lang.odt
    echo "Generating PDF locale “$lang”..."
    odt2pdf $name.odt
  fi
done
if [[ -z "$langask" || (! -z "$langask" && "$langask" = "en") ]]; then
  cp -r odt odt-en
  cp -L images/en/* odt-en/Pictures/
  find odt-en -name '.svn' -exec rm -f '{}' \; 2>/dev/null
  (
    cd odt-en
    zip -r ../SalixStartupGuide-en.odt * >/dev/null
  )
  rm -rf odt-en
  echo "Generating PDF locale “en”..."
  odt2pdf SalixStartupGuide-en.odt
fi
