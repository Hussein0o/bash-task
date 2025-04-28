#!/bin/bash

if [[ "$1" == "--help" ]]; then
    echo "Usage: ./mygrep.sh [-n] [-v] search_string filename"
    exit 0
fi

show_line_numbers=false
invert_match=false

while [[ "$1" == -* ]]; do
    if [[ "$1" == "-n" ]]; then
        show_line_numbers=true
    elif [[ "$1" == "-v" ]]; then
        invert_match=true
    elif [[ "$1" == "-vn" || "$1" == "-nv" ]]; then
        show_line_numbers=true
        invert_match=true
    else
        echo "Unknown option: $1"
        exit 1
    fi
    shift
done

search="$1"
file="$2"

if [[ -z "$search" || -z "$file" ]]; then
    echo "Error: Missing search string or filename."
    exit 1
fi

if [[ ! -f "$file" ]]; then
    echo "Error: File not found."
    exit 1
fi

line_number=0
while IFS= read -r line; do
    ((line_number++))
    if echo "$line" | grep -iq "$search"; then
        match=true
    else
        match=false
    fi

    if $invert_match; then
        if $match; then
            match=false
        else
            match=true
        fi
    fi

    if $match; then
        if $show_line_numbers; then
            echo "$line_number:$line"
        else
            echo "$line"
        fi
    fi
done < "$file"
