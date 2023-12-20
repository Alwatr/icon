#!/usr/bin/env bash

set -Eeuo pipefail
trap "echo '❌ Error'" ERR

function echoColor() {
  # 1: red, 2: green, 3: yellow, 4: blue, 5: purple, 6: cyan, 7: light gray
  echo -e "\x1b[0;3$1m$2\x1b[0m"
}

function echoWarn() {
  echoColor 3 "⚠️  $1"
}

function echoStep() {
  echoColor 6 "\n🔸 $1\n"
}

downloadName=material-design-icons

if [ -f ${downloadName}.zip ]; then
  echoWarn "${downloadName}.zip exists"
else
  echoStep 'Downloading...'
  curl -Lo ${downloadName}.zip https://github.com/google/material-design-icons/archive/refs/heads/master.zip
fi

echoStep 'Clean up...'
echo -n 'clean up: '
rm -rfv material-design-icons-master ${downloadName} svg | wc -l

echoStep 'Extract...'
unzip -q ${downloadName}.zip 'material-design-icons-master/symbols/web/*' -d ./
mv material-design-icons-master/symbols/web ${downloadName}
rm -rf material-design-icons-master

echo ''
echo -n 'Icon count: '
ls -l ${downloadName} | wc -l

mkdir -p svg/outline
mkdir -p svg/fill
# mkdir svg/round
# mkdir svg/sharp

echoStep 'Processed icons'
cd  ${downloadName}
count=0
for iconName in *
do
  (( count++ ))
  if (( count % 100 == 0 ))
  then
    echo "$count"
  fi

  mv ./${iconName}/materialsymbolsoutlined/${iconName}_wght300_24px.svg ../svg/outline/${iconName}.svg
  mv ./${iconName}/materialsymbolsoutlined/${iconName}_wght300fill1_24px.svg ../svg/fill/${iconName}.svg

  sed -i 's/height="24" width="24"/viewBox="0 0 24 24"/' ../svg/outline/${iconName}.svg
  sed -i 's/height="24" width="24"/viewBox="0 0 24 24"/' ../svg/fill/${iconName}.svg
done
echo "$count done"
cd ..

echo ''
echo -n 'clean up: '
rm -rfv ${downloadName} | wc -l

rename 's/_/-/g' svg/*/*

echo -n 'Done: '
ls -l svg/outline | wc -l

cat svg/outline/home.svg

rm -i ${downloadName}.zip
