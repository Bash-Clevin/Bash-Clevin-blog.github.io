#!/bin/bash

convert_to_special_case() {
  echo "$1" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2));}1'
}

sanitize_filename() {
 echo "$1" | tr -cd '[:alnum:] ' | tr '[:upper:]' '[:lower:]' | tr -s ' ' | tr ' ' '-'
}


## Print date in format yyyy-mm-dd, used to create file  
current_date=$(date +%F)

template_date=$(date +"%Y-%m-%d %H:%M:%S %z" -d "+3 hours")

# Prompt for post title
read -p "Enter the post title: " post_title

formated_file_name=$(sanitize_filename "$post_title")

title=$(convert_to_special_case "$post_title")

file_name="${current_date}-${formated_file_name}.md"

template="---
layout: post
title: \"$title\"
date: $template_date
categories: \"\"
tags: \"\"
image:
  path: \"\"
  lqip: \"\"
---
"

echo -e "$template" > "./_posts/$file_name"

echo "Jekyll post file '$file_name' created successfully."