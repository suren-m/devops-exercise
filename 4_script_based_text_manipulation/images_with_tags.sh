#!/usr/bin/env bash

#-----------------
# Script that prints out docker images along with their tags in 'imagename:tag' format

# Optionally takes an argument to filter images by their names (comma separated args)
# usage e.g: ./images_with_tags.sh litecoin,nginx
#-----------------

image_names=$1

if [[ -z "$image_names" ]]; 
then        
  docker images | sed '1d' | awk '{print $1 ":" $2}'
else 
  filter=$(echo "$image_names" | tr ',' '|')
  docker images | grep -E $filter | awk '{print $1 ":" $2}'
fi

    