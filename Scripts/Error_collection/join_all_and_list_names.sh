#!/bin/bash

output_file="output.txt"  # Name of the output file

# Remove the output file if it already exists
if [ -e "$output_file" ]; then
    rm "$output_file"
fi

# Loop through all text files in the directory
for file in *.csv; do
    # Skip the output file itself
    if [ "$file" != "$output_file" ]; then
        # Concatenate the content of each file and append it to the output file
        cat "$file" >> "$output_file"
    fi
done

cut -d'|' -f1 "$output_file" | sort>output_names.txt
echo "Content of all text files has been concatenated into $output_file"
