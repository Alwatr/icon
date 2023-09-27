#!/bin/bash

rm -rf svg
mkdir -p svg/outline
mkdir svg/round
mkdir svg/sharp

cd original
for icon in ./*; do
  cp -av ./${icon}/materialsymbolsoutlined/${icon}_24px.svg ../svg/outline/${icon}.svg
  cp -av ./${icon}/materialsymbolsrounded/${icon}_24px.svg ../svg/round/${icon}.svg
  cp -av ./${icon}/materialsymbolssharp/${icon}_24px.svg ../svg/sharp/${icon}.svg
done

cd ../svg
rename 's/_/-/g' **/**
