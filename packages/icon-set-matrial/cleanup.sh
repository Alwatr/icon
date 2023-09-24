#!/bin/bash

rename 's/_/-/g' *

mkdir outline
mkdir rounded
mkdir sharp

for icon_dir in ./*; do

  icon_name=$(basename "$icon_dir")

  for sub_dir in "$icon_dir"/*; do

    sub_dir_name=$(basename "$sub_dir")

    svg_path="$sub_dir/${icon_name}_24px.svg"

    if [ -f "$svg_path" ]; then
      case "$sub_dir_name" in
      "materialsymbolsoutlined")
        cp "$svg_path" "outline/$icon_name-24.svg"
        ;;
      "materialsymbolsrounded")
        cp "$svg_path" "rounded/$icon_name-24.svg"
        ;;
      "materialsymbolssharp")
        cp "$svg_path" "sharp/$icon_name-24.svg"
        ;;
      esac
    fi
  done
done
