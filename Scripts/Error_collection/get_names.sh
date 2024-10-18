#!/bin/bash

files=$(ls | grep "^$1" $2)
file_string=""

for file in $files; do
    file_string+=" $file"
done

echo "$file_string"
