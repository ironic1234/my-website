#!/bin/bash
#
# Generates a multi-resolution favicon.ico from a single character and a custom font.
#
# REQUIREMENTS:
# - ImageMagick: A command-line tool for image manipulation.
#   - macOS: brew install imagemagick
#   - Debian/Ubuntu: sudo apt-get install imagemagick
#   - Windows: Download from https://imagemagick.org/script/download.php
#
# USAGE:
# 1. Customize the variables below.
# 2. Make the script executable: chmod +x create_favicon.sh
# 3. Run the script: ./create_favicon.sh

set -e # Exit immediately if a command exits with a non-zero status.

# --- CUSTOMIZE THESE VARIABLES ---

# The character or text you want in the favicon (short is better!)
TEXT="RJ"

# The path to your custom TrueType (.ttf) or OpenType (.otf) font file.
# IMPORTANT: Replace this with the actual path to your font.
FONT_PATH="/Users/ronak/Library/Fonts/Hack-Regular.ttf" # Example for macOS, change this!

# Background color. Use "transparent" for a clear background.
# Any color name or hex code (e.g., "#4A90E2") works.
BG_COLOR="transparent"

# Text color.
TEXT_COLOR="#fab387"

# The base size for the largest icon version. The text will be scaled from this.
CANVAS_SIZE=256

# Pointsize of the font. You may need to adjust this for your specific font and character.
POINT_SIZE=150

# The final output filename.
OUTPUT_FILE="favicon.ico"

# --- SCRIPT LOGIC ---

# Array of standard favicon sizes to generate.
SIZES=(16 32 48 64)

# Temporary file array
PNG_FILES=()

echo "Starting favicon generation..."

# Check if font file exists
if [ ! -f "$FONT_PATH" ]; then
    echo "Error: Font file not found at '$FONT_PATH'"
    echo "Please update the FONT_PATH variable in the script."
    exit 1
fi

# Generate a PNG for each required size
for SIZE in "${SIZES[@]}"; do
    TEMP_FILE="favicon_${SIZE}.png"
    echo "-> Generating ${TEMP_FILE}..."
    convert \
        -size ${CANVAS_SIZE}x${CANVAS_SIZE} \
        xc:"${BG_COLOR}" \
        -font "${FONT_PATH}" \
        -pointsize ${POINT_SIZE} \
        -fill "${TEXT_COLOR}" \
        -gravity center \
        -annotate +0+0 "${TEXT}" \
        -trim \
        -resize ${SIZE}x${SIZE} \
        -gravity center \
        -background "${BG_COLOR}" \
        -extent ${SIZE}x${SIZE} \
        "${TEMP_FILE}"
    PNG_FILES+=("${TEMP_FILE}")
done

# Combine all generated PNGs into a single .ico file
echo "-> Combining PNGs into ${OUTPUT_FILE}..."
convert "${PNG_FILES[@]}" "${OUTPUT_FILE}"

# Clean up the temporary PNG files
echo "-> Cleaning up temporary files..."
rm "${PNG_FILES[@]}"

echo ""
echo "✅ Success! Your favicon has been created as '${OUTPUT_FILE}'."
echo "It contains the following sizes: ${SIZES[*]}x${SIZES[*]}."
