#!/bin/bash
set -euo pipefail

bucket="$1"
book_dir="$2"

mkdir -p "$book_dir"
book_dir="$(realpath "$book_dir")"

aws s3 cp "s3://$bucket/" "$book_dir" --recursive --exclude "*" --include "*.txt"

echo "File path" > book_list.txt
find "$book_dir" -maxdepth 1 -name "*.txt" | LC_ALL=C sort >> book_list.txt

count=$(tail -n +2 book_list.txt | wc -l)
echo "Wrote $count book files to book_list.txt"
