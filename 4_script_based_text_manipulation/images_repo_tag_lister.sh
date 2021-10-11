#!/usr/bin/env bash

#-----------------
# Script that prints out docker images along with their tags in 'repo:tag' format

# Optionally takes an argument to filter repos by their names (comma separated args)
# usage e.g: ./images_repo_tag_lister.sh litecoin,nginx
#-----------------

repos=$1

if [[ -z "$repos" ]]; 
then        
  docker images | sed '1d' | awk '{print $1 ":" $2}'
else 
  filter=$(echo "$repos" | tr ',' '|')
  docker images | grep -E $filter | awk '{print $1 ":" $2}'
fi

    