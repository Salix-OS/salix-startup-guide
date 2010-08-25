#!/binsh
cd $(dirname "$0")
for f in $(grep -l 'xmlns:grddl' odt/*); do
  sed -i 's_xmlns:grddl="http://www\.w3\.org/2003/g/data-view#"__; s_grddl:transformation="http://docs\.oasis-open\.org/office/1\.2/xslt/odf2rdf\.xsl"__' $f
done
