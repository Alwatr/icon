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

downloadFileName=material-design-icons.zip

if [ -f $downloadFileName ]
then
  echoWarn "$downloadFileName exists"
else
  curl -Lo $downloadFileName https://github.com/google/material-design-icons/archive/refs/heads/master.zip
fi

unzip -j $downloadFileName 'material-design-icons-master/symbols/web/*' -d ./original

rm -rf svg
mkdir -p svg/outline
mkdir svg/fill
# mkdir svg/round
# mkdir svg/sharp

for iconName in ./*
do
  cp -av ./original/${iconName}/materialsymbolsoutlined/${iconName}_wght300_24px.svg ./svg/outline/${iconName}.svg
  cp -av ./original/${iconName}/materialsymbolsoutlined/${iconName}_wght300fill1_24px.svg ./svg/fill/${iconName}.svg

  sed -i 's/height="24" width="24"/viewBox="0 0 24 24"/' ./svg/outline/${iconName}.svg
  sed -i 's/height="24" width="24"/viewBox="0 0 24 24"/' ./svg/fill/${iconName}.svg
done

cd svg
rename 's/_/-/g' **/**
