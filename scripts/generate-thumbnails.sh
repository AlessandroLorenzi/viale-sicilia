#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

ROOMS_DIR="FOTO/ROOMS"
MOSAIC_DIR="dist/thumbnails/MOSAIC"
CAROSELLO_DIR="dist/thumbnails/CAROSELLO"

echo "Rimuovo thumbnail esistenti..."
rm -rf "$MOSAIC_DIR" "$CAROSELLO_DIR"
mkdir -p "$MOSAIC_DIR" "$CAROSELLO_DIR"

watermark_resize() {
    local src="$1" dst="$2" size="$3" fontsize1="$4" fontsize2="$5"
    local margin=$(( fontsize1 / 2 ))
    local off2=$(( fontsize1 + fontsize2 / 2 ))
    mkdir -p "$(dirname "$dst")"
    convert "$src" -auto-orient -resize "${size}x${size}>" -strip \
        -gravity south \
        -fill "rgba(255,255,255,0.3)" -stroke "rgba(0,0,0,0.2)" -strokewidth 1 \
        -font Helvetica -pointsize "$fontsize2" \
        -annotate +0+${margin} "Viale Sicilia 4 - Busto Arsizio" \
        -font Helvetica-Bold -pointsize "$fontsize1" \
        -annotate +0+${off2} "ALESSANDRO LORENZI" \
        -quality 82 "$dst"
}

find "$ROOMS_DIR" -mindepth 2 -maxdepth 2 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' \) -not -path '*/PANORAMA/*' | sort | \
while IFS= read -r src; do
    rel="${src#"$ROOMS_DIR"/}"
    echo "Genero thumbnail per $rel"
    watermark_resize "$src" "$MOSAIC_DIR/$rel" 800 24 15
    watermark_resize "$src" "$CAROSELLO_DIR/$rel" 1600 40 24
done

echo "Fatto."
