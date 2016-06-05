#!/bin/bash
# Replaces relative urls in wintersmith blog build artefacts 

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]
then
  echo "Usage: $0 wsBuildDir wsLocalsUrl newUrl"
  exit
fi

dir=$(pwd)

echo -e "Path:\t$1"
urlOld=$(echo ${2//\//\\/})
urlNew=$(echo ${3//\//\\/})
echo -e "UrlOld: $2 > sed --> $urlOld"
echo -e "UrlNew: $3 > sed --> $urlNew"

cd $1

# Make all css, articles and page links absolute
grep -rl /css/main.css . | xargs sed -i 's/\/css\/main.css/'$urlNew'\/css\/main.css/g'
grep -rl $2/articles . | xargs sed -i 's/'$urlOld'\/articles/\/articles/g'
grep -rl /articles . | xargs sed -i 's/\/articles/'$urlNew'\/articles/g'
grep -rl /page . | xargs sed -i 's/\/page/'$urlNew'\/page/g'

# Relpace all absolute old urls with the new one
grep -rl $2 . | xargs sed -i 's/'$urlOld'/'$urlNew'/g'

# Replace all links to the root of the webside
grep -rl 'href="/"' . | xargs sed -i 's/href=\"\/\"/href=\"'$urlNew'\"/g'

# Substitute all archives.html links
grep -rl /archive.html . | xargs sed -i 's/\/archive.html/'$urlNew'\/archive.html/g'

cd $dir
