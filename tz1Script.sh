#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

input_dir=$1
output_dir=$2

mkdir -p "$output_dir"

copy_files() {
    local source_path=$1
    local dest_path=$2
    local filename=$(basename "$source_path")

    if [[ -e "$dest_path/$filename" ]]; then
        local base_name="${filename%.*}"
        local extension="${filename##*.}"
        local counter=1
        while [[ -e "$dest_path/${base_name}_$counter.$extension" ]]; do
            ((counter++))
        done
        filename="${base_name}_$counter.$extension"
    fi

    cp "$source_path" "$dest_path/$filename"
}

export -f copy_files
export output_dir
find "$input_dir" -type f -exec bash -c 'copy_files "$0" "$output_dir"' {} \;


