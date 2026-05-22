#!/bin/bash

# Input file (old HTML)
INPUT="old_links.html"

# Output file (new format)
OUTPUT="new_links.html"

# Clear output file
> "$OUTPUT"

# Read categories from old HTML (assumes <ul class="links hidden" data-tab="CATEGORY">)
grep -oP '<ul class="links hidden" data-tab="\K[^"]+' "$INPUT" | while read category; do
    # Write category container
    echo "<!-- $category -->" >> "$OUTPUT"
    echo "<div class=\"link-category\">" >> "$OUTPUT"
    echo "  <div class=\"category-title\">${category^^}</div>" >> "$OUTPUT"  # uppercase
    echo "  <div class=\"category-links\">" >> "$OUTPUT"

    # Extract links inside this ul
    sed -n "/<ul class=\"links hidden\" data-tab=\"$category\">/,/<\/ul>/p" "$INPUT" \
        | grep -oP '<a href="\K[^"]+' \
        | while read url; do
            # Get link text from <a> tag
            text=$(grep -oP "<a href=\"$url\">\\K[^<]+" "$INPUT")
            echo "    <a href=\"$url\">$text</a>" >> "$OUTPUT"
        done

    echo "  </div>" >> "$OUTPUT"
    echo "</div>" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
done

echo "Conversion complete! Output saved to $OUTPUT"
